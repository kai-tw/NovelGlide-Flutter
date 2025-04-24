part of '../collection_add_book_scaffold.dart';

class _Navigation extends StatelessWidget {
  const _Navigation();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final _Cubit cubit = BlocProvider.of<_Cubit>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: SafeArea(
        child: OverflowBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const CollectionAddDialog(),
                ).then((_) {
                  cubit.refresh();
                });
              },
              icon: const Icon(Icons.add),
              label: Text(appLocalizations.generalAdd),
            ),
            TextButton.icon(
              onPressed: () async {
                Navigator.of(context).pop();
                cubit.save();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(appLocalizations.collectionSaved),
                  ),
                );
              },
              icon: const Icon(Icons.save_rounded),
              label: Text(appLocalizations.generalSave),
            ),
          ],
        ),
      ),
    );
  }
}
