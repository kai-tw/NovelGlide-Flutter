part of '../bookshelf.dart';

class _Checkbox extends StatelessWidget {
  final BookData bookData;

  const _Checkbox({required this.bookData});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, CommonListState<BookData>>(
      buildWhen: (previous, current) =>
          previous.selectedSet != current.selectedSet,
      builder: (context, state) {
        return Checkbox(
          value: state.selectedSet.contains(bookData),
          onChanged: (_) => _SliverListItem.onTap(cubit, bookData),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          semanticLabel: appLocalizations.bookshelfAccessibilityCheckbox,
        );
      },
    );
  }
}
