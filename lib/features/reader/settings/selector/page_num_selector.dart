part of '../reader_bottom_sheet.dart';

class _PageNumSelector extends StatelessWidget {
  const _PageNumSelector();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<ReaderCubit, ReaderState>(
        buildWhen: (previous, current) =>
            previous.readerSettings.pageNumType !=
            current.readerSettings.pageNumType,
        builder: (context, state) {
          return DropdownMenu<ReaderSettingsPageNumType>(
            width: constraints.maxWidth,
            label: Text(appLocalizations.readerPageNumTypeLabel),
            helperText: appLocalizations.readerPageNumTypeHelperText,
            trailingIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              semanticLabel: appLocalizations.readerPageNumTypeHelperText,
            ),
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up_rounded,
              semanticLabel: appLocalizations.readerPageNumTypeHelperText,
            ),
            initialSelection: state.readerSettings.pageNumType,
            onSelected: (value) {
              cubit.setSettings(pageNumType: value);
              cubit.saveSettings();
            },
            dropdownMenuEntries: ReaderSettingsPageNumType.values
                .map<DropdownMenuEntry<ReaderSettingsPageNumType>>(
                    (type) => _createEntry(appLocalizations, type))
                .toList(),
          );
        },
      );
    });
  }

  DropdownMenuEntry<ReaderSettingsPageNumType> _createEntry(
    AppLocalizations appLocalizations,
    ReaderSettingsPageNumType type,
  ) {
    String label;
    switch (type) {
      case ReaderSettingsPageNumType.hidden:
        label = appLocalizations.readerPageNumTypeHidden;
        break;
      case ReaderSettingsPageNumType.number:
        label = appLocalizations.readerPageNumTypeNumber;
        break;
      case ReaderSettingsPageNumType.percentage:
        label = appLocalizations.readerPageNumTypePercentage;
        break;
      case ReaderSettingsPageNumType.progressBar:
        label = appLocalizations.readerPageNumTypeProgressBar;
        break;
    }
    return DropdownMenuEntry<ReaderSettingsPageNumType>(
      value: type,
      label: label,
    );
  }
}
