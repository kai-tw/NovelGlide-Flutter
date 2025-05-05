import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/PopupMenuUtils.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../enum/sort_order_code.dart';
import '../../../../enum/window_class.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../common_components/common_delete_dialog.dart';
import '../../../common_components/common_loading.dart';
import '../../../common_components/draggable_feedback_widget.dart';
import '../../../common_components/draggable_placeholder_widget.dart';
import '../../../common_components/shared_list/shared_list.dart';
import '../../../homepage/cubit/homepage_cubit.dart';
import '../../../reader/presentation/reader_page/cubit/reader_cubit.dart';
import '../../../reader/presentation/reader_page/reader.dart';
import '../../data/bookmark_data.dart';
import '../../data/bookmark_repository.dart';
import 'cubit/cubit.dart';

part 'bookmark_list_app_bar.dart';
part 'bookmark_list_scaffold_body.dart';
part 'widgets/bookmark_list_app_bar_more_button.dart';
part 'widgets/bookmark_widget.dart';
part 'widgets/draggable_bookmark.dart';
part 'widgets/list_item.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    BlocProvider.of<BookmarkListCubit>(context).refresh();

    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      buildWhen: (BookmarkListState previous, BookmarkListState current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList,
      builder: (BuildContext context, BookmarkListState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return SharedListSliverEmpty(
                title: appLocalizations.bookmarkListNoBookmark,
              );
            } else {
              return SliverPadding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.paddingOf(context).bottom,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
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
