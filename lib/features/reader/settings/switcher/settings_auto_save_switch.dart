part of '../../reader.dart';

class _SettingsAutoSaveSwitch extends StatelessWidget {
  const _SettingsAutoSaveSwitch();

  @override
  Widget build(BuildContext context) {
    final _ReaderCubit cubit = BlocProvider.of<_ReaderCubit>(context);
    return BlocBuilder<_ReaderCubit, _ReaderState>(
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
