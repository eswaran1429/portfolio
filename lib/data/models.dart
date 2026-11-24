import 'package:flutter/material.dart';

class Project {
  final String slug;
  final String title;
  final String summary;
  final List<String> features;
  final List<String> tech;
  final String? image; // asset path, e.g. assets/images/taxi.webp
  final String? liveUrl; // Play Store link

  const Project({
    required this.slug,
    required this.title,
    required this.summary,
    required this.features,
    required this.tech,
    this.image,
    this.liveUrl,
  });
}

class Service {
  final String title;
  final String description;
  final IconData icon;

  const Service({required this.title, required this.description, required this.icon});
}

class Experience {
  final String role;
  final String company;
  final String period;
  final List<String> points;

  const Experience({required this.role, required this.company, required this.period, required this.points});
}

class SocialLink {
  final String label;
  final String url;

  /// Material icon, used when [asset] is null.
  final IconData? icon;

  /// Logo image path, e.g. assets/images/github.png.
  final String? asset;

  /// Recolor a single-color [asset] to the theme's text color (keeps black logos visible in dark mode).
  final bool tintAsset;

  const SocialLink({required this.label, required this.url, this.icon, this.asset, this.tintAsset = false})
    : assert(icon != null || asset != null);
}
