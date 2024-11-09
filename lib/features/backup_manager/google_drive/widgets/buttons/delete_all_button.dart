part of '../../backup_manager_google_drive.dart';

class _DeleteAllButton extends StatelessWidget {
  const _DeleteAllButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.libraryId != current.libraryId ||
          previous.collectionId != current.collectionId ||
          previous.bookmarkId != current.bookmarkId,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded &&
            state.libraryId != null &&
            state.collectionId != null &&
            state.bookmarkId != null;
        return IconButton(
          icon: Icon(
            Icons.delete_outlined,
            semanticLabel: appLocalizations.backupManagerDeleteAllBackup,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);

    if (cubit.state.libraryId == null ||
        cubit.state.collectionId == null ||
        cubit.state.bookmarkId == null) {
      cubit.refresh();
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) => _ProcessCubit()
          ..deleteAll(
            libraryId: cubit.state.libraryId!,
            collectionId: cubit.state.collectionId!,
            bookmarkId: cubit.state.bookmarkId!,
          ),
        child: const _ProcessAllDialog(),
      ),
    ).then((value) => cubit.refresh());
  }
}
