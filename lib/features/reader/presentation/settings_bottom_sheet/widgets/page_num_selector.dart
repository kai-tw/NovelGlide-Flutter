part of '../reader_bottom_sheet.dart';

class _PageNumSelector extends StatelessWidget {
  const _PageNumSelector();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return BlocBuilder<ReaderCubit, ReaderState>(
        buildWhen: (ReaderState previous, ReaderState current) =>
            previous.readerPreference.pageNumType !=
            current.readerPreference.pageNumType,
        builder: (BuildContext context, ReaderState state) {
          return DropdownMenu<ReaderPageNumType>(
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
            initialSelection: state.readerPreference.pageNumType,
            onSelected: (ReaderPageNumType? value) {
              if (value != null) {
                cubit.pageNumType = value;
                cubit.saveSettings();
              }
            },
            dropdownMenuEntries: ReaderPageNumType.values
                .map<DropdownMenuEntry<ReaderPageNumType>>(
                    (ReaderPageNumType type) =>
                        _createEntry(appLocalizations, type))
                .toList(),
          );
        },
      );
    });
  }

  DropdownMenuEntry<ReaderPageNumType> _createEntry(
    AppLocalizations appLocalizations,
    ReaderPageNumType type,
  ) {
    String label;
    switch (type) {
      case ReaderPageNumType.hidden:
        label = appLocalizations.readerPageNumTypeHidden;
        break;
      case ReaderPageNumType.number:
        label = appLocalizations.readerPageNumTypeNumber;
        break;
      case ReaderPageNumType.percentage:
        label = appLocalizations.readerPageNumTypePercentage;
        break;
      case ReaderPageNumType.progressBar:
        label = appLocalizations.readerPageNumTypeProgressBar;
        break;
    }
    return DropdownMenuEntry<ReaderPageNumType>(
      value: type,
      label: label,
    );
  }
}
