import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollectionAddCancelButton extends StatelessWidget {
  const CollectionAddCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return TextButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.close_rounded),
      label: Text(appLocalizations?.generalCancel ?? 'Cancel'),
    );
  }
}
