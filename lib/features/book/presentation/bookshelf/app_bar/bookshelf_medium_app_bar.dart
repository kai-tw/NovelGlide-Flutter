part of '../bookshelf.dart';

class BookshelfMediumAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const BookshelfMediumAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AppBar(
      leading: const Icon(Icons.book_outlined),
      leadingWidth: 100.0,
      title: Text(appLocalizations.bookshelfTitle),
      actions: const <Widget>[
        SharedListSelectAllButton<BookshelfCubit>(),
        SharedListDoneButton<BookshelfCubit>(),
        SharedListSelectModeButton<BookshelfCubit>(),
      ],
    );
  }
}
