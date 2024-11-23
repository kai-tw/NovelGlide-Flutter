part of '../reader_bottom_sheet.dart';

class _AutoSaveSwitch extends StatelessWidget {
  const _AutoSaveSwitch();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.autoSave != current.readerSettings.autoSave,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title:
              Text(AppLocalizations.of(context)!.readerSettingsAutoSaveSwitch),
          value: state.readerSettings.autoSave,
          onChanged: (bool value) {
            cubit.setSettings(autoSave: value);
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
