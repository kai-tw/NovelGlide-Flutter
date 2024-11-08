part of '../../backup_manager_google_drive.dart';

class _DeleteBookButton extends StatelessWidget {
  const _DeleteBookButton();

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
            Icons.delete_outlined,
            semanticLabel: appLocalizations.backupManagerDeleteLibraryBackup,
          ),
          onPressed: isEnabled
              ? () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return FutureBuilder<bool>(
                        future: cubit.deleteLibrary(),
                        builder: (context, snapshot) => buildBackupDialog(
                          context,
                          snapshot,
                          appLocalizations
                              .backupManagerDeleteBackupSuccessfully,
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
