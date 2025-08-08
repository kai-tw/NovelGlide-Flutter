part of '../../../collection_service.dart';

class CollectionAddForm extends StatelessWidget {
  const CollectionAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Form(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              appLocalizations.collectionAddTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: CollectionAddNameField(),
            ),
            const OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CollectionAddCloseButton(),
                CollectionAddSubmitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
