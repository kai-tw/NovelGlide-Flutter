part of '../reader_bottom_sheet.dart';

class _AutoSaveSwitch extends StatelessWidget {
  const _AutoSaveSwitch();

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.readerPreference.isAutoSaving !=
          current.readerPreference.isAutoSaving,
      builder: (BuildContext context, ReaderState state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(AppLocalizations.of(context)!.readerAutoSave),
          value: state.readerPreference.isAutoSaving,
          onChanged: (bool value) {
            cubit.isAutoSaving = value;
            cubit.savePreference();
          },
        );
      },
    );
  }
}
