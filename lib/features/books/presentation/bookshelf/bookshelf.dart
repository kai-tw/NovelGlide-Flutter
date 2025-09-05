import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../collection/presentation/collection_list/collection_list_scroll_view.dart';
import '../book_list/book_list_scroll_view.dart';
import 'cubit/bookshelf_cubit.dart';

class Bookshelf extends StatefulWidget {
  const Bookshelf({super.key});

  @override
  State<Bookshelf> createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  AppLocalizations get appLocalizations => AppLocalizations.of(context)!;

  BookshelfCubit get cubit => BlocProvider.of<BookshelfCubit>(context);

  @override
  void initState() {
    super.initState();
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
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: 'All Books'),
            Tab(text: appLocalizations.generalCollection(2)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              BookListScrollView(),
              CollectionListScrollView(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
