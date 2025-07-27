part of '../collection_add_dialog.dart';

class _TitleText extends StatelessWidget {
  const _TitleText();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Text(
      appLocalizations.collectionAddTitle,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
