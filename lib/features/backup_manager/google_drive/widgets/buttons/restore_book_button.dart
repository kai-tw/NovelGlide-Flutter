part of '../../backup_manager_google_drive.dart';

class _RestoreBookButton extends StatelessWidget {
  const _RestoreBookButton();

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
            Icons.restore_outlined,
            semanticLabel: appLocalizations.backupManagerRestoreLibrary,
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
        create: (_) => _ProcessCubit()..restoreLibrary(cubit.state.libraryId!),
        child: const _ProcessAllDialog(),
      ),
    );
  }
}
