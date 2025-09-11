import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../collection/presentation/collection_list/collection_list_scroll_view.dart';
import '../../../collection/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../book_list/book_list_scroll_view.dart';
import '../book_list/cubit/book_list_cubit.dart';
import 'cubit/bookshelf_cubit.dart';
import 'cubit/bookshelf_state.dart';

class Bookshelf extends StatefulWidget {
  const Bookshelf({super.key});

  @override
  State<Bookshelf> createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: cubit.state.tabIndex,
    );

    // Listen to tab changes and update the state accordingly.
    _tabController.addListener(() {
      cubit.switchTab(_tabController.index);
    });

    // Listen to animation changes and update the state accordingly.
    _tabController.animation?.addListener(() {
      cubit.setTabRunning(
          _tabController.animation?.value != _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);

    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        // BookList dragging listener
        BlocListener<BookListCubit, BookListState>(
          listenWhen: (BookListState previous, BookListState current) =>
              previous.isDragging != current.isDragging,
          listener: (BuildContext _, BookListState state) {
            // Disable tabs while dragging a book.
            cubit.setTabEnabled(!state.isDragging);
          },
        ),
        // CollectionList dragging listener
        BlocListener<CollectionListCubit, CollectionListState>(
          listenWhen:
              (CollectionListState previous, CollectionListState current) =>
                  previous.isDragging != current.isDragging,
          listener: (BuildContext _, CollectionListState state) {
            // Disable tabs while dragging a collection.
            cubit.setTabEnabled(!state.isDragging);
          },
        ),
      ],
      child: Column(
        children: <Widget>[
          BlocBuilder<BookshelfCubit, BookshelfState>(
            buildWhen: (BookshelfState previous, BookshelfState current) =>
                previous.enableTab != current.enableTab,
            builder: (BuildContext context, BookshelfState state) {
              return IgnorePointer(
                ignoring: !state.enableTab,
                child: TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(text: appLocalizations.allBooks),
                    Tab(text: appLocalizations.generalCollection(2)),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<BookshelfCubit, BookshelfState>(
              buildWhen: (BookshelfState previous, BookshelfState current) =>
                  previous.enableTab != current.enableTab,
              builder: (BuildContext context, BookshelfState state) {
                return TabBarView(
                  controller: _tabController,
                  physics: state.enableTab
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  children: const <Widget>[
                    BookListScrollView(),
                    CollectionListScrollView(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
