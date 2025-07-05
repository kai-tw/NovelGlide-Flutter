part of 'bookmark_list.dart';

class BookmarkListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);

    return AppBar(
      leading: const Icon(Icons.bookmarks_outlined),
      leadingWidth: windowClass == WindowSize.compact ? null : 100.0,
      title: Text(appLocalizations.bookmarkListTitle),
      actions: const <Widget>[
        SharedListSelectAllButton<BookmarkListCubit>(),
        SharedListDoneButton<BookmarkListCubit>(),
        BookmarkListAppBarMoreButton(),
      ],
    );
  }
}
