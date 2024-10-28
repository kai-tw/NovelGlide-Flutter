import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPagePrivacyButton extends StatelessWidget {
  const AboutPagePrivacyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return TextButton.icon(
      onPressed: () => launchUrl(
        Uri.parse('https://blog.kai-wu.net/p/novelglide-privacy-policy.html'),
      ),
      icon: const Icon(Icons.shield_rounded),
      label: Text(appLocalizations.privacyPolicy),
    );
  }
}
