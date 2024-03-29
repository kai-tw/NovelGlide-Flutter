import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common_failed_dialog.dart';
import 'common_processing_dialog.dart';
import 'common_success_dialog.dart';

class CommonFormSubmitButton extends StatelessWidget {
  const CommonFormSubmitButton({super.key, this.onPressed});

  final Future<bool> Function()? onPressed;

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
      onPressed: () {
        if (onPressed != null && Form.of(context).validate()) {
          showDialog(context: context, barrierDismissible: false, builder: (_) => const CommonProcessingDialog());
          Form.of(context).save();
          onPressed!().then((bool isSuccess) {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (_) => isSuccess ? const CommonSuccessDialog() : const CommonFailedDialog())
                .then((_) => Navigator.of(context).pop(isSuccess));
          });
        }
      },
    );
  }
}
