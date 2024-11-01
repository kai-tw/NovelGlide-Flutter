part of 'bookmark_list.dart';

class BookmarkListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookmarkListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final WindowClass windowClass =
        WindowClass.fromWidth(MediaQuery.of(context).size.width);

    return AppBar(
      leading: const Icon(Icons.bookmarks_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(appLocalizations.bookmarkListTitle),
      actions: const [
        _SelectButton(),
        _DoneButton(),
        _PopupMenuButton(),
      ],
    );
  }
}
