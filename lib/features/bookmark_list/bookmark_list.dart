import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/bookmark_data.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../enum/window_class.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../repository/bookmark_repository.dart';
import '../../utils/route_utils.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_list/list_template.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../common_components/draggable_feedback_widget.dart';
import '../common_components/draggable_placeholder_widget.dart';
import '../reader/cubit/reader_cubit.dart';
import '../reader/reader.dart';
import 'cubit/cubit.dart';

part 'bookmark_list_app_bar.dart';
part 'widgets/bookmark_widget.dart';
part 'widgets/draggable_bookmark.dart';
part 'widgets/list_item.dart';
part 'widgets/popup_menu_button.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    BlocProvider.of<BookmarkListCubit>(context).refresh();

    return BlocBuilder<BookmarkListCubit, CommonListState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return CommonSliverListEmpty(
                title: appLocalizations.bookmarkListNoBookmark,
              );
            } else {
              return SliverPadding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
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
