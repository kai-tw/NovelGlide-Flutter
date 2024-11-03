part of '../../reader.dart';

class _SettingsLineHeightSlider extends StatelessWidget {
  const _SettingsLineHeightSlider();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.lineHeight !=
          current.readerSettings.lineHeight,
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final cubit = BlocProvider.of<_ReaderCubit>(context);
        return _SettingsSlider(
          leading: Icon(
            Icons.density_small_rounded,
            color: Theme.of(context).colorScheme.primary,
            semanticLabel:
                appLocalizations.accessibilityLineHeightSliderMinIcon,
          ),
          trailing: Icon(
            Icons.density_large_rounded,
            color: Theme.of(context).colorScheme.primary,
            semanticLabel:
                appLocalizations.accessibilityLineHeightSliderMaxIcon,
          ),
          min: ReaderSettingsData.minLineHeight,
          max: ReaderSettingsData.maxLineHeight,
          value: state.readerSettings.lineHeight,
          semanticFormatterCallback: (value) {
            return '${appLocalizations.accessibilityLineHeightSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (value) {
            cubit.setSettings(lineHeight: value);
          },
          onChangeEnd: (value) {
            cubit.setSettings(lineHeight: value);
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
