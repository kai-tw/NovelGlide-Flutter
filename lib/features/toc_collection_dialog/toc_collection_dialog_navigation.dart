import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../collection_add/collection_add_dialog.dart';
import 'bloc/toc_collection_dialog_bloc.dart';

class TocCollectionDialogNavigation extends StatelessWidget {
  const TocCollectionDialogNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final TocCollectionDialogCubit cubit = BlocProvider.of<TocCollectionDialogCubit>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
            label: Text(appLocalizations.generalClose),
          ),
          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const CollectionAddDialog(),
              ).then((_) {
                cubit.refresh();
              });
            },
            icon: const Icon(Icons.add),
            label: Text(appLocalizations.generalAdd),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              cubit.save();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.collectionSaved),
                ),
              );
            },
            icon: const Icon(Icons.save_rounded),
            label: Text(appLocalizations.generalSave),
          ),
        ],
      ),
    );
  }
}