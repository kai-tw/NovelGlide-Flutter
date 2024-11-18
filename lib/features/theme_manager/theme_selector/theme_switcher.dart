part of '../theme_manager.dart';

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher({required this.themeId});

  final ThemeId themeId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final themeName = ThemeId.getThemeNameById(context, themeId);
    final brightness = Theme.of(context).brightness;
    final themeData = themeId.getThemeDataByBrightness(brightness);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeSwitcher.switcher(
          builder: (context, switcher) {
            return OutlinedButton(
              onPressed: () {
                ThemeDataRecord.saveId(themeId);
                switcher.changeTheme(theme: themeData);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                backgroundColor: themeData.colorScheme.primaryContainer,
                foregroundColor: themeData.colorScheme.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: themeData.colorScheme.outline),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "Aa",
                overflow: TextOverflow.ellipsis,
                semanticsLabel: appLocalizations
                    .accessibilityThemeSelectionButton(themeName ?? "Aa"),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(themeName ?? "Aa", overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
