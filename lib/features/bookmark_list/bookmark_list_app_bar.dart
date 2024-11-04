part of 'bookmark_list.dart';

class BookmarkListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    return AppBar(
      leading: const Icon(Icons.bookmarks_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(appLocalizations.bookmarkListTitle),
      actions: const [
        CommonListSelectAllButton<BookmarkListCubit, BookmarkData>(),
        CommonListDoneButton<BookmarkListCubit, BookmarkData>(),
        _PopupMenuButton(),
      ],
    );
  }
}
