import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/collection_data.dart';
import '../../data/loading_state_code.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'bloc/toc_collection_dialog_bloc.dart';

class TocCollectionDialogList extends StatelessWidget {
  const TocCollectionDialogList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final TocCollectionDialogCubit cubit = BlocProvider.of<TocCollectionDialogCubit>(context);

    return BlocBuilder<TocCollectionDialogCubit, TocCollectionDialogState>(
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonLoading();

          case LoadingStateCode.loaded:
            if (state.collectionList.isEmpty) {
              return const CommonListEmpty();
            } else {
              return ListView.builder(
                itemCount: state.collectionList.length,
                itemBuilder: (context, index) {
                  final CollectionData data = state.collectionList[index];

                  return ListTile(
                    onTap: () => _onTap(cubit, state.selectedCollections, data.id),
                    contentPadding: const EdgeInsets.fromLTRB(16, 0.0, 8.0, 0.0),
                    leading: const Icon(Icons.folder),
                    title: Text(data.name),
                    trailing: Semantics(
                      label: appLocalizations.collectionSelect,
                      child: Checkbox(
                        value: state.selectedCollections.contains(data.id),
                        onChanged: (_) => _onTap(cubit, state.selectedCollections, data.id),
                      ),
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }

  void _onTap(TocCollectionDialogCubit cubit, Set<String> set, String id) {
    if (set.contains(id)) {
      cubit.deselect(id);
    } else {
      cubit.select(id);
    }
  }
}
