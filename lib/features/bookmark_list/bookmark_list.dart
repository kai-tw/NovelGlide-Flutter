import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/sliver_list_empty.dart';
import '../../shared/sliver_loading.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_sliver_app_bar.dart';
import 'bookmark_list_sliver_list.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookmarkListCubit(),
      child: BlocBuilder<BookmarkListCubit, BookmarkListState>(
        builder: (BuildContext context, BookmarkListState state) {
          final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
          List<Widget> sliverList = [];

          sliverList.add(const BookmarkListSliverAppBar());

          switch (state.code) {
            case BookmarkListStateCode.unload:
              cubit.refresh();
            case BookmarkListStateCode.empty:
              sliverList.add(const CommonSliverListEmpty());
              break;
            case BookmarkListStateCode.loading:
              sliverList.add(const CommonSliverLoading());
              break;
            case BookmarkListStateCode.normal:
              sliverList.add(const BookmarkListSliverList());
          }

          return CustomScrollView(slivers: sliverList);
        },
      ),
    );
  }
}
