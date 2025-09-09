import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../homepage/homepage.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'cubit/bookmark_list_cubit.dart';
import 'widgets/bookmark_list_app_bar_more_button.dart';

class BookmarkListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      leading: const Icon(Icons.bookmarks_rounded),
      title: appLocalizations.generalBookmark(2),
      actions: const <Widget>[
        SharedListSelectAllButton<BookmarkListCubit>(),
        SharedListDoneButton<BookmarkListCubit>(),
        BookmarkListAppBarMoreButton(),
      ],
    );
  }
}
