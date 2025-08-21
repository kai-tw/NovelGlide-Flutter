import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../shared_components/common_error_widgets/common_error_sliver_widget.dart';
import '../../../shared_components/common_loading_widgets/common_loading_sliver_widget.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'cubit/bookshelf_cubit.dart';
import 'widgets/bookshelf_list_item.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (BookshelfState previous, BookshelfState current) =>
          previous.code != current.code ||
          previous.dataList != current.dataList ||
          previous.sortOrder != current.sortOrder ||
          previous.isAscending != current.isAscending ||
          previous.listType != current.listType,
      builder: (BuildContext context, BookshelfState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            // Loading...
            return const CommonSliverLoading();

          case LoadingStateCode.error:
            // Error
            return const CommonErrorSliverWidget();

          case LoadingStateCode.backgroundLoading:
          case LoadingStateCode.loaded:
            if (state.dataList.isEmpty) {
              // No books.
              return SharedListSliverEmpty(
                title: appLocalizations.bookshelfNoBook,
              );
            } else {
              // Show books.
              return SliverPadding(
                padding: EdgeInsets.only(
                  // Avoid books from being covered by the navigation bar.
                  bottom: MediaQuery.paddingOf(context).bottom + 72.0,
                ),
                sliver: SharedList(
                  listType: state.listType,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0,
                    childAspectRatio: 150 / 300,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return BookshelfSliverListItem(
                        bookData: state.dataList[index],
                      );
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
