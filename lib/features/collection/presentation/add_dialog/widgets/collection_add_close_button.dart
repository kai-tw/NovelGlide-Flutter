import 'package:flutter/material.dart';

import '../../../../../generated/i18n/app_localizations.dart';

class CollectionAddCloseButton extends StatelessWidget {
  const CollectionAddCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return TextButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.close_rounded),
      label: Text(appLocalizations.generalCancel),
    );
  }
}
