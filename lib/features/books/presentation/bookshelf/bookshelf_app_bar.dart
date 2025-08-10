import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../homepage/homepage.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'cubit/bookshelf_cubit.dart';
import 'widgets/bookshelf_app_bar_more_button.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      iconData: Icons.shelves,
      title: appLocalizations.generalBookshelf,
      actions: const <Widget>[
        SharedListSelectAllButton<BookshelfCubit>(),
        SharedListDoneButton<BookshelfCubit>(),
        BookshelfAppBarMoreButton(),
      ],
    );
  }
}
