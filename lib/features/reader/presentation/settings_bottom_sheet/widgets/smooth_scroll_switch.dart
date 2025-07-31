part of '../reader_bottom_sheet.dart';

class _SmoothScrollSwitch extends StatelessWidget {
  const _SmoothScrollSwitch();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (ReaderState previous, ReaderState current) =>
          previous.readerPreference.isSmoothScroll !=
          current.readerPreference.isSmoothScroll,
      builder: (BuildContext context, ReaderState state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(appLocalizations.readerFlippingAnime),
          value: state.readerPreference.isSmoothScroll,
          onChanged: (bool value) {
            cubit.isSmoothScroll = value;
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
