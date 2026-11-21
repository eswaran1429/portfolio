import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';
import 'package:portfolio/core/custom_widgets/profile_sidebar/profile_sidebar.dart';
import 'package:portfolio/data/portfolio_data.dart';

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const PortfolioApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('wide: sidebar pinned, theme toggles', (tester) async {
    await _pumpAt(tester, const Size(1440, 900));

    expect(find.byType(ProfileSidebar), findsOneWidget);
    expect(find.text(PortfolioData.name), findsOneWidget); // sidebar only, not repeated in hero

    await tester.tap(find.byTooltip('Toggle theme'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
  });

  testWidgets('narrow: sidebar opens as drawer', (tester) async {
    await _pumpAt(tester, const Size(390, 844));

    expect(find.byType(ProfileSidebar), findsNothing);
    await tester.tap(find.byTooltip('Profile'));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileSidebar), findsOneWidget);
  });

  testWidgets('showcase: arrows switch project and wrap around', (tester) async {
    await _pumpAt(tester, const Size(1440, 1400));
    final n = PortfolioData.projects.length.toString().padLeft(2, '0');

    expect(find.text('01 / $n'), findsOneWidget);
    await tester.ensureVisible(find.byTooltip('Next project'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Next project'));
    await tester.pumpAndSettle();
    expect(find.text('02 / $n'), findsOneWidget);

    await tester.tap(find.byTooltip('Previous project'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Previous project'));
    await tester.pumpAndSettle();
    expect(find.text('$n / $n'), findsOneWidget);
  });
}
