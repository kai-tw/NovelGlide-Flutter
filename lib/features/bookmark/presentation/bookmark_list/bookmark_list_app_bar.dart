part of 'bookmark_list.dart';

class BookmarkListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      iconData: Icons.bookmarks_rounded,
      title: appLocalizations.bookmarkListTitle,
      actions: const <Widget>[
        SharedListSelectAllButton<BookmarkListCubit>(),
        SharedListDoneButton<BookmarkListCubit>(),
        BookmarkListAppBarMoreButton(),
      ],
    );
  }
}
