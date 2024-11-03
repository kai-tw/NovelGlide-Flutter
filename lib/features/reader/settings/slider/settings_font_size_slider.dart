part of '../../reader.dart';

class _SettingsFontSizeSlider extends StatelessWidget {
  const _SettingsFontSizeSlider();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ReaderCubit, _ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.fontSize != current.readerSettings.fontSize,
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final cubit = BlocProvider.of<_ReaderCubit>(context);
        return _SettingsSlider(
          leading: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.minFontSize,
            semanticLabel: appLocalizations.accessibilityFontSizeSliderMinIcon,
          ),
          trailing: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderSettingsData.maxFontSize,
            semanticLabel: appLocalizations.accessibilityFontSizeSliderMaxIcon,
          ),
          min: ReaderSettingsData.minFontSize,
          max: ReaderSettingsData.maxFontSize,
          value: state.readerSettings.fontSize,
          semanticFormatterCallback: (value) {
            return '${appLocalizations.accessibilityFontSizeSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (value) {
            cubit.setSettings(fontSize: value);
          },
          onChangeEnd: (value) {
            cubit.setSettings(fontSize: value);
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
