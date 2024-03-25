import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonSuccessDialog extends StatelessWidget {
  const CommonSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.check_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.secondary,
      content: Text(
        AppLocalizations.of(context)!.add_successful,
        textAlign: TextAlign.center,
      ),
    );
  }
}