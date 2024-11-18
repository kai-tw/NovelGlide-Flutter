part of '../theme_manager.dart';

class _ThemeCardTitle extends StatelessWidget {
  const _ThemeCardTitle();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.imagesearch_roller_outlined),
      title: Text(
        appLocalizations.themeListTitle,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(appLocalizations.themeListDescription),
    );
  }
}
