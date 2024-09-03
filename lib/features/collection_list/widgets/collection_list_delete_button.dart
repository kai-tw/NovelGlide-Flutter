import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_delete_dialog.dart';
import '../bloc/collection_list_bloc.dart';

class CollectionListDeleteButton extends StatelessWidget {
  const CollectionListDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionListCubit cubit = BlocProvider.of<CollectionListCubit>(context);

    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CommonDeleteDialog(
              onDelete: () => cubit.deleteSelectedCollections(),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Theme.of(context).colorScheme.error,
        fixedSize: const Size(double.infinity, 56.0),
        minimumSize: const Size(double.infinity, 56.0),
      ),
      icon: const Icon(Icons.delete_rounded),
      label: BlocBuilder<CollectionListCubit, CollectionListState>(
        buildWhen: (previous, current) => previous.selectedCollections != current.selectedCollections,
        builder: (context, state) {
          return Text(appLocalizations.collectionDelete(state.selectedCollections.length));
        },
      ),
    );
  }
}
