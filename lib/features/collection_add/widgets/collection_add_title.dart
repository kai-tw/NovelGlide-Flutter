import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollectionAddTitle extends StatelessWidget {
  const CollectionAddTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Text(
      appLocalizations?.collectionAddTitle ?? 'Add Collection',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}