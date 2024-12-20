part of '../../backup_manager_google_drive.dart';

class _DeleteBookButton extends StatelessWidget {
  const _DeleteBookButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.libraryId != current.libraryId,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded && state.libraryId != null;
        return IconButton(
          icon: Icon(
            Icons.delete_outlined,
            semanticLabel: appLocalizations.backupManagerDeleteLibraryBackup,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);

    if (cubit.state.libraryId == null) {
      cubit.refresh();
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) => _ProcessCubit()..deleteLibrary(cubit.state.libraryId!),
        child: const _ProcessAllDialog(),
      ),
    ).then((value) => cubit.refresh());
  }
}
