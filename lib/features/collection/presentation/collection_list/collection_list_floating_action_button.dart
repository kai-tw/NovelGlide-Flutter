import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../add_dialog/collection_add_dialog.dart';

class CollectionListFloatingActionButton extends StatelessWidget {
  const CollectionListFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return FloatingActionButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const CollectionAddDialog(),
        );
      },
      tooltip: appLocalizations.collectionAddBtn,
      child: const Icon(Icons.add),
    );
  }
}
