part of '../bookshelf.dart';

class BookshelfCompactAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookshelfCompactAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return AppBar(
      leading: const Icon(Icons.book_outlined),
      title: Text(appLocalizations.bookshelfTitle),
      actions: const <Widget>[
        SharedListSelectAllButton<BookshelfCubit>(),
        SharedListDoneButton<BookshelfCubit>(),
        BookshelfCompactAppBarMoreButton(),
      ],
    );
  }
}
