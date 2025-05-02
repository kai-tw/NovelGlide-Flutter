part of '../shared_list.dart';

class SharedListSelectModeButton extends StatelessWidget {
  const SharedListSelectModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const SizedBox(width: 24.0),
      title: Text(appLocalizations.generalSelect),
      trailing: const Icon(Icons.check_circle_outline_rounded),
    );
  }
}
