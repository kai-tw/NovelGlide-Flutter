part of '../reader_bottom_sheet.dart';

class _LineHeightSlider extends StatelessWidget {
  const _LineHeightSlider();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.lineHeight !=
          current.readerSettings.lineHeight,
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        final cubit = BlocProvider.of<ReaderCubit>(context);
        return _SettingsSlider(
          leading: Icon(
            Icons.density_small_rounded,
            color: Theme.of(context).colorScheme.primary,
            semanticLabel: appLocalizations.readerMinLineHeight,
          ),
          trailing: Icon(
            Icons.density_large_rounded,
            color: Theme.of(context).colorScheme.primary,
            semanticLabel: appLocalizations.readerMaxLineHeight,
          ),
          min: ReaderSettingsData.minLineHeight,
          max: ReaderSettingsData.maxLineHeight,
          value: state.readerSettings.lineHeight,
          semanticFormatterCallback: (value) {
            return '${appLocalizations.readerLineHeightSlider} ${value.toStringAsFixed(1)}';
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
