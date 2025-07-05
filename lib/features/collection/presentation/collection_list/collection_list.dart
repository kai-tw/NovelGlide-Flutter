import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_components/common_delete_dialog.dart';
import '../../../../core/shared_components/common_loading.dart';
import '../../../../core/shared_components/draggable_feedback_widget.dart';
import '../../../../core/shared_components/draggable_placeholder_widget.dart';
import '../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../core/utils/popup_menu_utils.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../enum/sort_order_code.dart';
import '../../../../enum/window_size.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../homepage/cubit/homepage_cubit.dart';
import '../../../homepage/homepage.dart';
import '../../data/collection_data.dart';
import '../../data/collection_repository.dart';
import '../collection_viewer/collection_viewer.dart';
import 'cubit/cubit.dart';

part 'collection_list_app_bar.dart';
part 'collection_list_scaffold_body.dart';
part 'widgets/collection_list_app_bar_more_button.dart';
part 'widgets/collection_widget.dart';
part 'widgets/draggable_collection.dart';
part 'widgets/list_item.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);

    BlocProvider.of<CollectionListCubit>(context).refresh();

    return BlocBuilder<CollectionListCubit, SharedListState<CollectionData>>(
      buildWhen: (SharedListState<CollectionData> previous, SharedListState<CollectionData> current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.isSelecting != current.isSelecting ||
          previous.selectedSet != current.selectedSet,
      builder: (BuildContext context, SharedListState<CollectionData> state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return SharedListSliverEmpty(
                title: appLocalizations.collectionNoCollection,
              );
            } else {
              return SliverPadding(
                padding: EdgeInsets.only(
                  top: windowClass == WindowSize.compact ? 0.0 : 16.0,
                  bottom: MediaQuery.paddingOf(context).bottom + 72.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _ListItem(state.dataList[index]);
                    },
                    childCount: state.dataList.length,
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
