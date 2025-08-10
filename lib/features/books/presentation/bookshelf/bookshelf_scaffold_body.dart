import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../homepage/cubit/homepage_cubit.dart';
import 'bookshelf.dart';
import 'bookshelf_loading_indicator.dart';
import 'cubit/bookshelf_cubit.dart';

class BookshelfScaffoldBody extends StatelessWidget {
  const BookshelfScaffoldBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepageCubit homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return Column(
      children: <Widget>[
        const BookshelfLoadingIndicator(),
        Expanded(
          child: PageStorage(
            bucket: homepageCubit.bookshelfBucket,
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              notificationPredicate: (_) => cubit.state.canRefresh,
              child: const Scrollbar(
                child: CustomScrollView(
                  key: PageStorageKey<String>('homepage-bookshelf'),
                  slivers: <Widget>[
                    Bookshelf(),
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
