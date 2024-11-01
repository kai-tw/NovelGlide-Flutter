part of '../bookshelf.dart';

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CommonDeleteDialog(
              onDelete: () => cubit.deleteSelectedBooks(),
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
      label: BlocBuilder<BookshelfCubit, _State>(
        buildWhen: (previous, current) =>
            previous.selectedBooks != current.selectedBooks,
        builder: (context, state) {
          return Text(appLocalizations.bookshelfDeleteNumberOfSelectedBooks(
              state.selectedBooks.length));
        },
      ),
    );
  }
}
