part of '../theme_manager.dart';

class _BrightnessSwitcher extends StatelessWidget {
  const _BrightnessSwitcher();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = context.read<ThemeManagerCubit>();

    return BlocBuilder<ThemeManagerCubit, ThemeManagerState>(
      buildWhen: (previous, current) =>
          previous.brightness != current.brightness,
      builder: (context, state) {
        return ThemeSwitcher.switcher(
          builder: (_, switcher) {
            return SegmentedButton<Brightness?>(
              segments: [
                ButtonSegment<Brightness?>(
                  value: null,
                  icon: Icon(
                    Icons.brightness_auto_rounded,
                    semanticLabel: appLocalizations.brightnessSystem,
                  ),
                ),
                ButtonSegment<Brightness?>(
                  value: Brightness.light,
                  icon: Icon(
                    Icons.light_mode_rounded,
                    semanticLabel: appLocalizations.brightnessLight,
                  ),
                ),
                ButtonSegment<Brightness?>(
                  value: Brightness.dark,
                  icon: Icon(
                    Icons.dark_mode_rounded,
                    semanticLabel: appLocalizations.brightnessDark,
                  ),
                ),
              ],
              selected: {state.brightness},
              onSelectionChanged: (brightnessSet) async {
                final brightness = brightnessSet.first;
                await ThemeDataRecord.saveBrightness(brightness);

                cubit.setBrightness(brightness);
                final themeData = await ThemeDataRecord.currentTheme;
                switcher.changeTheme(theme: themeData);
              },
            );
          },
        );
      },
    );
  }
}
