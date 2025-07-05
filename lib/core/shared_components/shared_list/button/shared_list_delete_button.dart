part of '../shared_list.dart';

class SharedListDeleteButton extends StatelessWidget {
  const SharedListDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: const Icon(Icons.delete_rounded),
      title: Text(appLocalizations.generalDelete),
    );
  }
}
