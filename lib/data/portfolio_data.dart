import 'package:flutter/material.dart';
import 'package:portfolio/data/models.dart';

class PortfolioData {
  static const name = 'Eswaran R';
  static const role = 'Flutter Developer';
  static const location = 'India';
  static const openToWork = false; // public "Open to Flutter roles" badge — hidden while employed
  static const email = 'eswaranr1429@gmail.com';
  static const resumeUrl = 'https://example.com/resume.pdf';

  static String get firstName => name.split(' ').first;
  static String get initials => name.split(' ').where((w) => w.isNotEmpty).map((w) => w[0]).take(2).join();

  // ---- Main page ----

  // Hero headline: before + [highlight] + after.
  static const headlineBefore = 'I ship Flutter apps used by';
  static const headlineHighlight = '15K+';
  static const headlineAfter = 'people.';
  static const tagline =
      'Flutter developer with 2+ years building production apps for taxi, insurance, and matrimony '
      'platforms — from first screen to Play Store and App Store release.';

  static const highlights = [('2+', 'Years'), ('6', 'Store apps'), ('15K+', 'Downloads')];

  static const _play = 'https://play.google.com/store/apps/details?id=';

  static const projects = [
    Project(
      slug: 'silver-taxi-driver',
      title: 'Silver Taxi Driver',
      summary: 'Driver app for a South Indian one-way taxi service. 10K+ downloads.',
      features: [
        'Ride requests, trip handling, and earnings tracking',
        'Live location, navigation, and push notifications',
        'Trip history and driver profile management',
      ],
      tech: ['Flutter', 'REST APIs', 'Location', 'Push Notifications'],
      liveUrl: '${_play}com.thereciprocalsolutions.silvertaxidriver',
    ),
    Project(
      slug: 'silver-taxi-customer',
      title: 'Silver Taxi Customer',
      summary: 'Taxi booking app for riders. 1K+ downloads.',
      features: [
        'Ride booking with fare estimation',
        'Live driver tracking and real-time trip updates',
        'Payments, ride history, and customer profiles',
      ],
      tech: ['Flutter', 'REST APIs', 'Live Tracking', 'Payments'],
      liveUrl: '${_play}com.silvertaxicustomer.silver_taxi_customer',
    ),
    Project(
      slug: 'silver-taxi-admin',
      title: 'Silver Taxi Admin',
      summary: 'Admin app for the Silver One Way Taxi service.',
      // TODO: add 2–3 features (Play Store description didn't load for me).
      features: [],
      tech: ['Flutter', 'REST APIs'],
      liveUrl: '${_play}com.thereciprocalsolutions.admin_app',
    ),
    Project(
      slug: 'ridedosh-partner',
      title: 'RideDosh Partner',
      summary: 'Driver partner app with real-time trip management. 1K+ downloads.',
      features: [
        'Real-time ride requests and driver status sync',
        'Socket-based live trip updates and instant notifications',
        'Location tracking and navigation workflows',
      ],
      tech: ['Flutter', 'WebSockets', 'REST APIs', 'Location'],
      liveUrl: '${_play}com.thereciprocalsolutions.vgo_cabs_app',
    ),
    Project(
      slug: 'qiic-insurance',
      title: 'QIIC Insurance',
      summary: 'Qatar Islamic Insurance Company customer app. 1K+ downloads.',
      features: [
        'Policy management, claims, and payments',
        'Secure payment gateway integration',
        'Arabic / English localization with real-time sync',
      ],
      tech: ['Flutter', 'REST APIs', 'Payment Gateway', 'Localization'],
      liveUrl: '${_play}com.azentio.qiicsmartapp.qiicsmartapp',
    ),
    Project(
      slug: 'kongu-elite-matrimony',
      title: 'Kongu Elite Matrimony',
      summary: 'Matrimony platform for profile discovery. 1K+ downloads.',
      features: [
        'Profile management and partner search',
        'Advanced filters, preferences, and matchmaking',
        'Secure authentication and multilingual UI',
      ],
      tech: ['Flutter', 'REST APIs', 'Authentication', 'Multilingual'],
    ),
  ];

  static const services = [
    Service(
      title: 'Mobile App Development',
      description: 'Cross-platform Flutter apps for Android and iOS with clean, responsive Material UI.',
      icon: Icons.phone_iphone_rounded,
    ),
    Service(
      title: 'Architecture & State',
      description: 'Scalable app structure with GetX and Provider that stays maintainable as features grow.',
      icon: Icons.account_tree_outlined,
    ),
    Service(
      title: 'APIs & Real-time',
      description: 'REST, Firebase, sockets, push notifications, and live location for real-time experiences.',
      icon: Icons.sync_alt_rounded,
    ),
    Service(
      title: 'Release & Maintenance',
      description: 'Play Store and App Store deployment, monitoring, and optimization for apps in production.',
      icon: Icons.rocket_launch_outlined,
    ),
  ];

  static const experience = [
    Experience(
      role: 'Flutter Developer',
      company: 'The Reciprocal Solutions',
      period: 'May 2026 — Present',
      points: [
        'Building and maintaining the Silver Taxi platform — driver (10K+ downloads), customer, and admin apps.',
        'Developed the Ridedosth Partner and Kongu Elite Matrimony apps for production release.',
        'Handle real-time trip updates, push notifications, live location, and Play Store releases.',
      ],
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'Younder Bots Private Limited',
      period: 'Sep 2025 — Jan 2026',
      points: [
        'Developed and optimized Flutter apps with REST API integration and Material UI.',
        'Implemented scalable state management using Provider and GetX.',
        'Deployed, monitored, and maintained production apps on the App Store.',
      ],
    ),
    Experience(
      role: 'Freelance Flutter Developer',
      company: 'Self-employed',
      period: 'Jan 2025 — May 2025',
      points: [
        'Built a course app with course listing, enrollment, and progress tracking.',
        'Designed responsive, scalable UI using Material Design.',
        'Integrated REST APIs for seamless cross-platform functionality.',
      ],
    ),
    Experience(
      role: 'Associate Engineer',
      company: 'Azentio Software',
      period: 'Feb 2023 — Sep 2024',
      points: [
        'Built cross-platform Flutter apps for Android and iOS.',
        'Integrated Firebase (Firestore, Authentication) and REST APIs.',
        'Deployed, monitored, and maintained production apps on the Play Store.',
      ],
    ),
  ];


  // ---- Sidebar ----

  static const profileInfo = [
    ('Residence', location),
    ('Degree', 'B.E. Computer Science'),
    ('College', 'Anna University'),
    ('CGPA', '8.2'),
  ];


  static const socials = [
    SocialLink(
      label: 'GitHub',
      asset: 'assets/images/github.png',
      tintAsset: true,
      url: 'https://github.com/eswaran1429/',
    ),
    SocialLink(
      label: 'LinkedIn',
      asset: 'assets/images/linkedin.png',
      url: 'https://www.linkedin.com/in/eswaran-r-a85545235/',
    ),
    SocialLink(label: 'Email', icon: Icons.mail_outline, url: 'mailto:$email'),
  ];
}
