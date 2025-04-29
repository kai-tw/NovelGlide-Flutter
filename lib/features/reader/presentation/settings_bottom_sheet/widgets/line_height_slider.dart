part of '../reader_bottom_sheet.dart';

class _LineHeightSlider extends StatelessWidget {
  const _LineHeightSlider();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.readerSettings.lineHeight !=
          current.readerSettings.lineHeight,
      builder: (BuildContext context, ReaderState state) {
        final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
        final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
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
          semanticFormatterCallback: (double value) {
            return '${appLocalizations.readerLineHeightSlider} ${value.toStringAsFixed(1)}';
          },
          onChanged: (double value) {
            cubit.lineHeight = value;
          },
          onChangeEnd: (double value) {
            cubit.lineHeight = value;
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
