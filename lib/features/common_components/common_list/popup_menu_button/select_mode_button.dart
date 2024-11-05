part of '../list_template.dart';

class CommonListSelectModeButton extends StatelessWidget {
  const CommonListSelectModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const SizedBox(width: 24.0),
      title: Text(appLocalizations.generalSelect),
      trailing: const Icon(Icons.check_circle_outline_rounded),
    );
  }
}
