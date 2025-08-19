part of '../reader_bottom_sheet.dart';

class _FontSizeSlider extends StatelessWidget {
  const _FontSizeSlider();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.readerPreference.fontSize !=
          current.readerPreference.fontSize,
      builder: (BuildContext context, ReaderState state) {
        final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
        final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
        return _SettingsSlider(
          leading: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderPreferenceData.minFontSize,
            semanticLabel: appLocalizations.readerMinFontSize,
          ),
          trailing: Icon(
            Icons.format_size_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: ReaderPreferenceData.maxFontSize,
            semanticLabel: appLocalizations.readerMaxFontSize,
          ),
          min: ReaderPreferenceData.minFontSize,
          max: ReaderPreferenceData.maxFontSize,
          value: state.readerPreference.fontSize,
          semanticFormatterCallback: (double value) {
            return '${appLocalizations.readerFontSizeSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (double value) {
            cubit.fontSize = value;
          },
          onChangeEnd: (double value) {
            cubit.fontSize = value;
            cubit.savePreference();
          },
        );
      },
    );
  }
}
