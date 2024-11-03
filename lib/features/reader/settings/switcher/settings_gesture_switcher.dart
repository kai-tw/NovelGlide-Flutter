part of '../../reader.dart';

class _SettingsGestureSwitcher extends StatelessWidget {
  const _SettingsGestureSwitcher();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final _ReaderCubit cubit = BlocProvider.of<_ReaderCubit>(context);
    return BlocBuilder<_ReaderCubit, _ReaderState>(
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
