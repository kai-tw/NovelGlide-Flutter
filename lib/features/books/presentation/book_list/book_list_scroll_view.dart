import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../homepage/cubit/homepage_cubit.dart';
import 'book_list.dart';
import 'cubit/bookshelf_cubit.dart';

class BookListScrollView extends StatelessWidget {
  const BookListScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final BookListCubit cubit = BlocProvider.of<BookListCubit>(context);

    return Column(
      children: <Widget>[
        // Loading indicator
        BlocBuilder<BookListCubit, BookListState>(
          buildWhen: (BookListState previous, BookListState current) =>
              previous.code != current.code,
          builder: (BuildContext context, BookListState state) {
            return state.code.isBackgroundLoading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink();
          },
        ),

        // Book List
        Expanded(
          child: PageStorage(
            bucket: homepageCubit.bookListBucket,
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              notificationPredicate: (_) => cubit.state.canRefresh,
              child: const Scrollbar(
                child: CustomScrollView(
                  key: PageStorageKey<String>('homepage-book-list'),
                  slivers: <Widget>[
                    BookList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
