import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/book_data.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../enum/window_class.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../utils/route_utils.dart';
import '../collection_add_book/collection_add_book_scaffold.dart';
import '../common_components/common_book_cover_image.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_error_dialog.dart';
import '../common_components/common_list/list_template.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../common_components/draggable_feedback_widget.dart';
import '../common_components/draggable_placeholder_widget.dart';
import '../table_of_contents/table_of_contents.dart';
import 'cubit/cubit.dart';

part 'bookshelf_app_bar.dart';
part 'widgets/book_widget.dart';
part 'widgets/draggable_book.dart';
part 'widgets/list_item.dart';
part 'widgets/popup_menu_button.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    BlocProvider.of<BookshelfCubit>(context).refresh();

    return BlocBuilder<BookshelfCubit, CommonListState<BookData>>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.isAscending != current.isAscending ||
          previous.sortOrder != current.sortOrder,
      builder: (context, state) {
        switch (state.code) {
          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return CommonSliverListEmpty(
                title: appLocalizations.bookshelfNoBook,
              );
            } else {
              final bottomPadding =
                  MediaQuery.of(context).padding.bottom + 48.0;
              return SliverPadding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0,
                    childAspectRatio: 150 / 300,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _SliverListItem(state.dataList[index]),
                    childCount: state.dataList.length,
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
