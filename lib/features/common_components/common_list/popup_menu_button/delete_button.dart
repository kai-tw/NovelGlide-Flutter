part of '../list_template.dart';

class CommonListDeleteButton extends StatelessWidget {
  const CommonListDeleteButton({super.key});

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
