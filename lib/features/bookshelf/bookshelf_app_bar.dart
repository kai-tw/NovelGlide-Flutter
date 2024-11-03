part of 'bookshelf.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

    return AppBar(
      leading: const Icon(Icons.book_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(appLocalizations.bookshelfTitle),
      actions: const [
        HomepageListSelectButton<BookshelfCubit, BookData>(),
        HomepageListDoneButton<BookshelfCubit, BookData>(),
        _PopupMenuButton(),
      ],
    );
  }
}
