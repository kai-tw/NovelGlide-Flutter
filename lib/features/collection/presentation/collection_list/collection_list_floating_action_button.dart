import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../add_dialog/collection_add_dialog.dart';

class CollectionListFloatingActionButton extends StatelessWidget {
  const CollectionListFloatingActionButton({
    super.key,
    this.enabled = true,
  });

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return FloatingActionButton(
      onPressed: enabled
          ? () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => const CollectionAddDialog(),
              );
            }
          : null,
      tooltip: appLocalizations.collectionAddBtn,
      child: const Icon(Icons.add),
    );
  }
}
