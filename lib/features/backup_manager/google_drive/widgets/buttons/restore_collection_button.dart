part of '../../backup_manager_google_drive.dart';

class _RestoreCollectionButton extends StatelessWidget {
  const _RestoreCollectionButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.collectionId != current.collectionId,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded && state.collectionId != null;
        return IconButton(
          icon: Icon(
            Icons.restore_outlined,
            semanticLabel: appLocalizations.backupManagerRestoreCollection,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);

    if (cubit.state.collectionId == null) {
      cubit.refresh();
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) =>
            _ProcessCubit()..restoreCollections(cubit.state.collectionId!),
        child: const _ProcessAllDialog(),
      ),
    );
  }
}
