import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/loading_state_code.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'bloc/toc_collection_dialog_bloc.dart';

class TocCollectionDialogList extends StatelessWidget {
  const TocCollectionDialogList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TocCollectionDialogCubit>(context);

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
                  final data = state.collectionList[index];

                  return CheckboxListTile(
                    contentPadding:
                        const EdgeInsets.fromLTRB(16, 0.0, 8.0, 0.0),
                    title: Text(data.name),
                    secondary: const Icon(Icons.folder),
                    value: state.selectedCollections.contains(data.id),
                    onChanged: (_) => _onTap(
                      cubit,
                      state.selectedCollections,
                      data.id,
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
