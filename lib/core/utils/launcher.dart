import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) => launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
