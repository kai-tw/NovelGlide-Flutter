import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/collection_data.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../enum/window_class.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../repository/collection_repository.dart';
import '../../utils/route_utils.dart';
import '../collection_viewer/collection_viewer.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_list/list_template.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../common_components/draggable_feedback_widget.dart';
import '../common_components/draggable_placeholder_widget.dart';
import 'cubit/cubit.dart';

part 'collection_list_app_bar.dart';
part 'widgets/collection_widget.dart';
part 'widgets/draggable_collection.dart';
part 'widgets/list_item.dart';
part 'widgets/popup_menu_button.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    BlocProvider.of<CollectionListCubit>(context).refresh();

    return BlocBuilder<CollectionListCubit, CommonListState<CollectionData>>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.isSelecting != current.isSelecting ||
          previous.selectedSet != current.selectedSet,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return CommonSliverListEmpty(
                title: appLocalizations.collectionNoCollection,
              );
            } else {
              return SliverPadding(
                padding: EdgeInsets.only(
                  top: windowClass == WindowClass.compact ? 0.0 : 16.0,
                  bottom: MediaQuery.of(context).padding.bottom + 72.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
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
