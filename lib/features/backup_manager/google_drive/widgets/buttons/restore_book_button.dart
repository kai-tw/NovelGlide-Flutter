part of '../../backup_manager_google_drive.dart';

class _RestoreBookButton extends StatelessWidget {
  const _RestoreBookButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<_Cubit>(context);
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
          onPressed: isEnabled
              ? () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return FutureBuilder<bool>(
                        future: cubit.restoreLibrary(),
                        builder: (context, snapshot) => buildBackupDialog(
                          context,
                          snapshot,
                          appLocalizations.backupManagerRestoreSuccessfully,
                        ),
                      );
                    },
                  )
              : null,
        );
      },
    );
  }
}
