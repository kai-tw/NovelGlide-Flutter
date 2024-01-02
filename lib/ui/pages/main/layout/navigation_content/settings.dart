import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.transparent,
        child: Center(
            child: Text(AppLocalizations.of(context)!.title_settings)
        )
    );
  }
}