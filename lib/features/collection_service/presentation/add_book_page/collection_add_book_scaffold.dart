part of '../../collection_service.dart';

class CollectionAddBookScaffold extends StatelessWidget {
  const CollectionAddBookScaffold({super.key, required this.dataSet});

  final Set<BookData> dataSet;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider<CollectionAddBookCubit>(
      create: (_) => CollectionAddBookCubit(dataSet),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.collectionAddToCollections),
        ),
        body: const SafeArea(
          child: CollectionAddBookList(),
        ),
        bottomNavigationBar: const CollectionAddBookNavigation(),
      ),
    );
  }
}
