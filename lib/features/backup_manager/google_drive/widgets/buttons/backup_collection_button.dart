part of '../../backup_manager_google_drive.dart';

class _BackupCollectionButton extends StatelessWidget {
  const _BackupCollectionButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded;
        return IconButton(
          icon: Icon(
            Icons.backup_outlined,
            semanticLabel: appLocalizations.backupManagerBackupCollection,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) => _ProcessCubit()..backupCollections(),
        child: const _ProcessAllDialog(),
      ),
    ).then((value) => cubit.refresh());
  }
}
