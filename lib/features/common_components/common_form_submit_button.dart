import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonFormSubmitButton extends StatelessWidget {
  const CommonFormSubmitButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      icon: const Icon(Icons.send_rounded),
      label: Text(
        AppLocalizations.of(context)!.submit,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      onPressed: onPressed,
    );
  }
}