part of '../../../collection_service.dart';

class _Navigation extends StatelessWidget {
  const _Navigation();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: SafeArea(
        child: OverflowBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Add a collection button
            TextButton.icon(
              onPressed: () => _onAddPressed(context),
              icon: const Icon(Icons.add),
              label: Text(appLocalizations.generalAdd),
            ),

            // Save button
            TextButton.icon(
              onPressed: () => _onSavePressed(context),
              icon: const Icon(Icons.save_rounded),
              label: Text(appLocalizations.generalSave),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddPressed(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CollectionAddDialog(),
    );
  }

  Future<void> _onSavePressed(BuildContext context) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final CollectionAddBookCubit cubit =
        BlocProvider.of<CollectionAddBookCubit>(context);

    // Save
    await cubit.save();

    // Show saved message
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appLocalizations.collectionSaved),
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
