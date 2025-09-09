import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../homepage/homepage.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'cubit/bookshelf_cubit.dart';
import 'widgets/book_list_app_bar_more_button.dart';

class BookListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      leading: const Icon(Icons.shelves),
      title: appLocalizations.generalBookshelf,
      actions: const <Widget>[
        SharedListSelectAllButton<BookListCubit>(),
        SharedListDoneButton<BookListCubit>(),
        BookListAppBarMoreButton(),
      ],
    );
  }
}
