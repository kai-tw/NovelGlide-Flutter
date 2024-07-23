import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../common_components/common_list_empty.dart';
import '../../common_components/common_loading.dart';
import '../bloc/book_manager_bloc.dart';
import 'book_manager_sliver_list_item.dart';

class BookManagerSliverList extends StatelessWidget {
  const BookManagerSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookManagerCubit, BookManagerState>(
      builder: (BuildContext context, BookManagerState state) {
        switch (state.code) {
          case BookManagerStateCode.normal:
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final BookData bookData = state.bookList[index];
                  return BookManagerSliverListItem(bookData: bookData);
                },
                childCount: state.bookList.length,
              ),
            );
          case BookManagerStateCode.loading:
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CommonLoading(),
              ),
            );
          default:
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CommonListEmpty(),
              ),
            );
        }
      },
    );
  }
}
