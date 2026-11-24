import 'package:flutter/material.dart';
import 'package:portfolio/core/custom_widgets/app_button/app_button.dart';
import 'package:portfolio/core/custom_widgets/circle_icon_button/circle_icon_button.dart';
import 'package:portfolio/core/custom_widgets/custom_text/custom_text.dart';
import 'package:portfolio/core/custom_widgets/doodle/doodle.dart';
import 'package:portfolio/core/custom_widgets/tag_chip/tag_chip.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/launcher.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/features/home/widgets/phone_mockup.dart';

/// Project carousel in a two-column card: phones | details + project list.
/// Changes only on user action: swipe, arrows, list rows, or side-phone taps.
class ProjectShowcase extends StatefulWidget {
  const ProjectShowcase({super.key});

  @override
  State<ProjectShowcase> createState() => _ProjectShowcaseState();
}

class _ProjectShowcaseState extends State<ProjectShowcase> {
  int _index = 0;
  int _dir = 1; // slide direction of the last change

  // One key per mobile pill, to scroll the selected pill into view.
  final _pillKeys = [for (final _ in PortfolioData.projects) GlobalKey()];

  int get _count => PortfolioData.projects.length;

  void _go(int step) => _select((_index + step + _count) % _count, dir: step.sign);

  void _select(int i, {int? dir}) {
    if (i == _index) return;
    setState(() {
      _dir = dir ?? (i > _index ? 1 : -1);
      _index = i;
    });
    // Arrows/swipe can select a pill that's scrolled off; bring it back into view.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _pillKeys[i].currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          alignment: 0.5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final wide = Responsive.isDesktop(context);
    final phones = Column(children: [_phones(), const SizedBox(height: 20), _controls()]);
    final details = _details(showList: wide);

    return Container(
      padding: EdgeInsets.all(wide ? 32 : 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.stroke),
      ),
      child: wide
          ? Row(
              children: [
                Expanded(child: phones),
                const SizedBox(width: 40),
                Expanded(child: details),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_pills(), const SizedBox(height: 20), phones, const SizedBox(height: 24), details],
            ),
    );
  }

  /// Mobile project picker: horizontally scrollable pills right above the phones.
  Widget _pills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (i, proj) in PortfolioData.projects.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            _ProjectPill(key: _pillKeys[i], label: proj.title, selected: i == _index, onTap: () => _select(i)),
          ],
        ],
      ),
    );
  }

  /// Stacked, tilted phones with glow + doodles. Swipeable.
  Widget _phones() {
    final projects = PortfolioData.projects;
    final p = projects[_index];

    return LayoutBuilder(
      builder: (context, c) {
        // Side phones reach ~1.03×phoneW from center; keep them inside the column.
        final phoneW = (c.maxWidth / 2.1).clamp(140.0, 210.0);
        final stackH = phoneW * PhoneMockup.aspect + 40;

        Widget sidePhone(int step, double angle) => Transform.translate(
          offset: Offset(phoneW * 0.62 * step, 24),
          child: Transform.rotate(
            angle: angle,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _go(step),
                child: Opacity(
                  opacity: 0.55,
                  child: PhoneMockup(project: projects[(_index + step + _count) % _count], width: phoneW * 0.82),
                ),
              ),
            ),
          ),
        );

        return GestureDetector(
          onHorizontalDragEnd: (d) {
            final v = d.primaryVelocity ?? 0;
            if (v < -150) _go(1);
            if (v > 150) _go(-1);
          },
          child: SizedBox(
            height: stackH,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.55,
                        colors: [
                          AppColors.accent.withValues(alpha: AppColors.isDark ? 0.18 : 0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                sidePhone(-1, -0.14),
                sidePhone(1, 0.14),
                const Positioned(top: 8, left: 8, child: Doodle(DoodleShape.circles, size: 34)),
                const Positioned(top: 40, right: 12, child: Doodle(DoodleShape.plus, size: 24)),
                Positioned(
                  bottom: 40,
                  left: 0,
                  child: Doodle(DoodleShape.zigzag, size: 44, color: AppColors.accentText),
                ),
                const Positioned(bottom: 8, right: 24, child: Doodle(DoodleShape.play, size: 34)),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 420),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, anim) {
                    // Incoming enters from the travel side; outgoing exits the opposite side.
                    final incoming = child.key == ValueKey(p.slug);
                    final dx = (incoming ? 0.35 : -0.35) * _dir;
                    return FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween(begin: Offset(dx, 0), end: Offset.zero).animate(anim),
                        child: child,
                      ),
                    );
                  },
                  child: PhoneMockup(key: ValueKey(p.slug), project: p, width: phoneW),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ← 01 / 05 → spread evenly under the phones.
  Widget _controls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleIconButton(tooltip: 'Previous project', icon: Icons.arrow_back_rounded, onTap: () => _go(-1)),
        CustomText(
          text: '${(_index + 1).toString().padLeft(2, '0')} / ${_count.toString().padLeft(2, '0')}',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textMuted,
        ),
        CircleIconButton(tooltip: 'Next project', icon: Icons.arrow_forward_rounded, onTap: () => _go(1)),
      ],
    );
  }

  /// Active project details, Play link, and (desktop) the full project list.
  Widget _details({required bool showList}) {
    final projects = PortfolioData.projects;
    final p = projects[_index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          layoutBuilder: (current, previous) => Stack(alignment: Alignment.topLeft, children: [...previous, ?current]),
          child: _Details(key: ValueKey(p.slug), index: _index),
        ),
        if (p.liveUrl != null) ...[
          const SizedBox(height: 18),
          AppButton(label: 'Google Play', icon: Icons.north_east, outlined: true, onTap: () => openLink(p.liveUrl!)),
        ],
        if (showList) ...[
          const SizedBox(height: 20),
          Divider(color: AppColors.stroke, height: 1),
          const SizedBox(height: 16),
          const _Eyebrow('All projects'),
          const SizedBox(height: 8),
          for (final (i, proj) in projects.indexed)
            _ProjectRow(number: i + 1, label: proj.title, selected: i == _index, onTap: () => _select(i)),
        ],
      ],
    );
  }
}

/// Mobile pill button for picking a project.
class _ProjectPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ProjectPill({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.textPrimary : Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: selected ? Colors.transparent : AppColors.stroke)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: CustomText(
            text: label,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.onInverse : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Title, summary, features, and tech for the active project.
class _Details extends StatelessWidget {
  final int index;

  const _Details({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final p = PortfolioData.projects[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: p.title, fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        const SizedBox(height: 4),
        CustomText(text: p.summary, fontSize: 14, height: 1.5, color: AppColors.textMuted),
        const SizedBox(height: 12),
        for (final f in p.features)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(Icons.check_rounded, size: 16, color: AppColors.accentText),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomText(text: f, fontSize: 13, height: 1.5, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        const _Eyebrow('Built with'),
        const SizedBox(height: 8),
        Wrap(spacing: 6, runSpacing: 6, children: [for (final t in p.tech) TagChip(label: t)]),
      ],
    );
  }
}

class _Eyebrow extends StatelessWidget {
  final String text;

  const _Eyebrow(this.text);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text.toUpperCase(),
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.6,
      color: AppColors.textMuted,
    );
  }
}

/// Full-width list row; selected row is highlighted.
class _ProjectRow extends StatefulWidget {
  final int number;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ProjectRow({required this.number, required this.label, required this.selected, required this.onTap});

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final active = selected || _hover;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.surfaceHigh : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CustomText(
                text: widget.number.toString().padLeft(2, '0'),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.accentText : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomText(
                  text: widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: active ? AppColors.textPrimary : AppColors.textMuted,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: active ? 1 : 0,
                child: Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.accentText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
