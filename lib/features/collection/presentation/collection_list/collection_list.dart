import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../../enum/window_size.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../shared_components/common_error_widgets/common_error_sliver_widget.dart';
import '../../../shared_components/common_loading_widgets/common_loading_sliver_widget.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'cubit/collection_list_cubit.dart';
import 'widgets/collection_list_item.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionListCubit, CollectionListState>(
      buildWhen: (CollectionListState previous, CollectionListState current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.sortOrder != current.sortOrder ||
          previous.isAscending != current.isAscending ||
          previous.listType != current.listType,
      builder: _buildList,
    );
  }

  Widget _buildList(BuildContext context, CollectionListState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final WindowSize windowClass = WindowSize.of(context);

    switch (state.code) {
      case LoadingStateCode.initial:
      case LoadingStateCode.loading:
      case LoadingStateCode.backgroundLoading:
        // Loading...
        return const CommonLoadingSliverWidget();

      case LoadingStateCode.error:
        // Error
        return const CommonErrorSliverWidget();

      case LoadingStateCode.loaded:
        if (state.dataList.isEmpty) {
          // No Collections.
          return SharedListSliverEmpty(
            title: appLocalizations.collectionNoCollection,
          );
        } else {
          // Show Collection List.
          return SliverPadding(
            padding: EdgeInsets.only(
              top: windowClass == WindowSize.compact ? 0.0 : 16.0,
              bottom: MediaQuery.paddingOf(context).bottom + 72.0,
            ),
            sliver: SharedList(
              listType: state.listType,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                childAspectRatio: 150 / 180,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CollectionListItem(
                    collectionData: state.dataList[index],
                  );
                },
                childCount: state.dataList.length,
              ),
            ),
          );
        }
    }
  }
}
