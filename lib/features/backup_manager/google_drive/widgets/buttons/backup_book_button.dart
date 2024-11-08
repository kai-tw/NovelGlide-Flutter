part of '../../backup_manager_google_drive.dart';

class _BackupBookButton extends StatelessWidget {
  const _BackupBookButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = BlocProvider.of<_Cubit>(context);
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded;
        return IconButton(
          icon: Icon(
            Icons.backup_outlined,
            semanticLabel: appLocalizations.backupManagerBackupLibrary,
          ),
          onPressed: isEnabled
              ? () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const _BackupBookProcessDialog(),
                  ).then((value) => cubit.refresh())
              : null,
        );
      },
    );
  }
}
