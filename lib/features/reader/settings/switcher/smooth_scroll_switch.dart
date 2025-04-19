part of '../reader_bottom_sheet.dart';

class _SmoothScrollSwitch extends StatelessWidget {
  const _SmoothScrollSwitch();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.readerSettings.isSmoothScroll !=
          current.readerSettings.isSmoothScroll,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(appLocalizations.readerFlippingAnime),
          value: state.readerSettings.isSmoothScroll,
          onChanged: (value) {
            cubit.isSmoothScroll = value;
            cubit.saveSettings();
          },
        );
      },
    );
  }
}
