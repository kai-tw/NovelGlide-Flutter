part of '../table_of_contents.dart';

class _CollectionScaffold extends StatelessWidget {
  final BookData bookData;

  const _CollectionScaffold({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => _CollectionCubit(bookData),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.collectionAddToCollections),
        ),
        body: const SafeArea(
          child: _CollectionList(),
        ),
        bottomNavigationBar: const _CollectionNavigation(),
      ),
    );
  }
}
