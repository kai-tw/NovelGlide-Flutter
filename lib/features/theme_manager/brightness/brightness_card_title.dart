part of '../theme_manager.dart';

class _BrightnessCardTitle extends StatelessWidget {
  const _BrightnessCardTitle();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.brightness_4_rounded),
      title: Text(
        appLocalizations.brightnessSelectorTitle,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(appLocalizations.brightnessSelectorDescription),
    );
  }
}
