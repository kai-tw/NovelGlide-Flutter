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
            label: Text(appLocalizations.readerSettingsPageNumTypeLabel),
            helperText: appLocalizations.readerSettingsPageNumTypeHelperText,
            trailingIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              semanticLabel:
                  appLocalizations.readerSettingsPageNumTypeHelperText,
            ),
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up_rounded,
              semanticLabel:
                  appLocalizations.readerSettingsPageNumTypeHelperText,
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
        label = appLocalizations.readerSettingsPageNumTypeHidden;
        break;
      case ReaderSettingsPageNumType.number:
        label = appLocalizations.readerSettingsPageNumTypeNumber;
        break;
      case ReaderSettingsPageNumType.percentage:
        label = appLocalizations.readerSettingsPageNumTypePercentage;
        break;
      case ReaderSettingsPageNumType.progressBar:
        label = appLocalizations.readerSettingsPageNumTypeProgressBar;
        break;
    }
    return DropdownMenuEntry<ReaderSettingsPageNumType>(
      value: type,
      label: label,
    );
  }
}
