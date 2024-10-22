import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPagePrivacyButton extends StatelessWidget {
  const AboutPagePrivacyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => launchUrl(
        Uri.parse('https://blog.kai-wu.net/p/novelglide-privacy-policy.html'),
      ),
      icon: const Icon(Icons.shield_rounded),
      label: const Text('Privacy Policy'),
    );
  }
}
