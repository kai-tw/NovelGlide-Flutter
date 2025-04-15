part of '../reader_bottom_sheet.dart';

class _AutoSaveSwitch extends StatelessWidget {
  const _AutoSaveSwitch();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.isAutoSaving !=
          current.readerSettings.isAutoSaving,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(AppLocalizations.of(context)!.readerAutoSave),
          value: state.readerSettings.isAutoSaving,
          onChanged: (bool value) {
            cubit.setSettings(autoSave: value);
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
