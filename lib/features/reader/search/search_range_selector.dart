part of 'search_scaffold.dart';

class _SearchRangeSelector extends StatelessWidget {
  const _SearchRangeSelector();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<ReaderSearchCubit>(context);
    return IntrinsicWidth(
      child: BlocBuilder<ReaderSearchCubit, ReaderSearchState>(
        builder: (context, state) {
          return Row(
            children: [
              _SearchRangeButton(
                isSelected: state.range == ReaderSearchRangeCode.currentChapter,
                onPressed: () =>
                    cubit.setRange(ReaderSearchRangeCode.currentChapter),
                label: appLocalizations.readerSearchCurrentChapter,
                icon: Icons.insert_drive_file_outlined,
              ),
              _SearchRangeButton(
                isSelected: state.range == ReaderSearchRangeCode.all,
                onPressed: () => cubit.setRange(ReaderSearchRangeCode.all),
                label: appLocalizations.readerSearchAllRange,
                icon: Icons.book_outlined,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SearchRangeButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final Function() onPressed;

  const _SearchRangeButton({
    required this.isSelected,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return TextButton.icon(
        onPressed: null,
        icon: Icon(icon),
        label: Text(label),
        style: TextButton.styleFrom(
          disabledBackgroundColor: Theme.of(context).colorScheme.primary,
          disabledForegroundColor: Theme.of(context).colorScheme.onPrimary,
          iconColor: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    } else {
      return IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.book_outlined),
        tooltip: label,
      );
    }
  }
}
