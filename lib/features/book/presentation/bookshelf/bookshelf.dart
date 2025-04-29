import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/route_utils.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../enum/sort_order_code.dart';
import '../../../../enum/window_class.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../ads_service/data/advertisement_type.dart';
import '../../../ads_service/presentation/advertisement.dart';
import '../../../collection/presentation/add_book_page/collection_add_book_scaffold.dart';
import '../../../common_components/common_book_cover_image.dart';
import '../../../common_components/common_delete_dialog.dart';
import '../../../common_components/common_error_dialog.dart';
import '../../../common_components/common_list/list_template.dart';
import '../../../common_components/common_list_empty.dart';
import '../../../common_components/common_loading.dart';
import '../../../common_components/draggable_feedback_widget.dart';
import '../../../common_components/draggable_placeholder_widget.dart';
import '../../../homepage/homepage.dart';
import '../../data/model/book_data.dart';
import '../table_of_contents_page/table_of_contents.dart';
import 'cubit/bookshelf_cubit.dart';

part 'bookshelf_app_bar.dart';
part 'bookshelf_loading_indicator.dart';
part 'bookshelf_scaffold_body.dart';
part 'widgets/book_widget.dart';
part 'widgets/draggable_book.dart';
part 'widgets/list_item.dart';
part 'widgets/popup_menu_button.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    BlocProvider.of<BookshelfCubit>(context).refresh();

    return BlocBuilder<BookshelfCubit, BookShelfState>(
      buildWhen: (BookShelfState previous, BookShelfState current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.isAscending != current.isAscending ||
          previous.sortOrder != current.sortOrder,
      builder: (BuildContext context, BookShelfState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.backgroundLoading:
          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              return CommonSliverListEmpty(
                title: appLocalizations.bookshelfNoBook,
              );
            } else {
              return _buildList(context, state);
            }
        }
      },
    );
  }

  Widget _buildList(BuildContext context, BookShelfState state) {
    // Avoid books from being covered by the navigation bar.
    final double bottomPadding = MediaQuery.paddingOf(context).bottom + 48.0;
    return SliverPadding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150.0,
          childAspectRatio: 150 / 300,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) =>
              _SliverListItem(state.dataList[index]),
          childCount: state.dataList.length,
        ),
      ),
    );
  }
}
