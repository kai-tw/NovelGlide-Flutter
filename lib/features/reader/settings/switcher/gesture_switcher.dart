part of '../reader_bottom_sheet.dart';

class _GestureSwitcher extends StatelessWidget {
  const _GestureSwitcher();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.gestureDetection !=
          current.readerSettings.gestureDetection,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(appLocalizations.readerSettingsGesture),
          value: state.readerSettings.gestureDetection,
          onChanged: (value) {
            cubit.setSettings(gestureDetection: value);
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
