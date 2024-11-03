part of '../table_of_contents.dart';

class _CollectionNavigation extends StatelessWidget {
  const _CollectionNavigation();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<_CollectionCubit>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: SafeArea(
        child: OverflowBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const CollectionAddDialog(),
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
