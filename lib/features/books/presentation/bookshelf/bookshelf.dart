import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../collection/presentation/collection_list/collection_list_scroll_view.dart';
import '../book_list/book_list_scroll_view.dart';
import 'cubit/bookshelf_cubit.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            onTap: cubit.switchTab,
            tabs: <Widget>[
              Tab(text: 'All Books'),
              Tab(text: appLocalizations.generalCollection(2)),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                BookListScrollView(),
                CollectionListScrollView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
