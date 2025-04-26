part of 'bookshelf.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowClass windowClass = WindowClass.fromWidth(windowWidth);

    return AppBar(
      leading: const Icon(Icons.book_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(appLocalizations.bookshelfTitle),
      actions: const <Widget>[
        CommonListSelectAllButton<BookshelfCubit, BookData>(),
        CommonListDoneButton<BookshelfCubit, BookData>(),
        _PopupMenuButton(),
      ],
    );
  }
}
