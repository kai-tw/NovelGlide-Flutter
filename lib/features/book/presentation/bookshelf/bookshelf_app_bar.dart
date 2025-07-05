part of 'bookshelf.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      iconData: Icons.book_outlined,
      title: appLocalizations.bookshelfTitle,
      actions: const <Widget>[
        SharedListSelectAllButton<BookshelfCubit>(),
        SharedListDoneButton<BookshelfCubit>(),
        BookshelfAppBarMoreButton(),
      ],
    );
  }
}
