import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_model/bookmark_data.dart';
import '../../data_model/preference_keys.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../enum/window_class.dart';
import '../../repository/bookmark_repository.dart';
import '../../utils/route_utils.dart';
import '../common_components/bookmark_widget.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_delete_drag_target.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../common_components/common_popup_menu_sort_list_tile.dart';
import '../common_components/common_select_mode_text_button.dart';
import '../common_components/draggable_feedback_widget.dart';
import '../common_components/draggable_placeholder_widget.dart';
import '../reader/reader.dart';

part 'bloc/cubit.dart';
part 'bookmark_list_app_bar.dart';
part 'bookmark_list_operation_panel.dart';
part 'widgets/delete_button.dart';
part 'widgets/done_button.dart';
part 'widgets/draggable_bookmark.dart';
part 'widgets/list_item.dart';
part 'widgets/popup_menu_button.dart';
part 'widgets/select_button.dart';

class BookmarkListSliverList extends StatelessWidget {
  const BookmarkListSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    BlocProvider.of<BookmarkListCubit>(context).refresh();

    return BlocBuilder<BookmarkListCubit, _State>(
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.loaded:
            if (state.bookmarkList.isEmpty) {
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
                    (BuildContext context, int index) {
                      return _ListItem(state.bookmarkList[index]);
                    },
                    childCount: state.bookmarkList.length,
                  ),
                ),
              );
            }

          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();
        }
      },
    );
  }
}