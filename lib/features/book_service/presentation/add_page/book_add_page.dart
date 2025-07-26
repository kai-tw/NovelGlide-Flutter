part of '../../book_service.dart';

class BookAddPage extends StatelessWidget {
  const BookAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider<BookAddCubit>(
      create: (_) => BookAddCubit(
        bookshelfCubit: BlocProvider.of<BookshelfCubit>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.addBookTitle),
        ),
        body: const BookAddFileList(),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: const SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BookAddHelperText(),
                BookAddActionBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
