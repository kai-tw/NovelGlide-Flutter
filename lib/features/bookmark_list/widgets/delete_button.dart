part of '../bookmark_list.dart';

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CommonDeleteDialog(
              onDelete: () => cubit.deleteSelectedBookmarks(),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Theme.of(context).colorScheme.error,
        fixedSize: const Size(double.infinity, 56.0),
        minimumSize: const Size(double.infinity, 56.0),
      ),
      icon: const Icon(Icons.delete_rounded),
      label: BlocBuilder<BookmarkListCubit, CommonListState>(
        buildWhen: (previous, current) =>
            previous.selectedSet != current.selectedSet,
        builder: (context, state) {
          return Text(
              appLocalizations.bookmarkListDeleteNumberOfSelectedBookmarks(
                  state.selectedSet.length));
        },
      ),
    );
  }
}
