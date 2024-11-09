part of '../../backup_manager_google_drive.dart';

class _DeleteBookmarkButton extends StatelessWidget {
  const _DeleteBookmarkButton();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<_Cubit, _State>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.bookmarkId != current.bookmarkId,
      builder: (context, state) {
        final isEnabled = state.code.isLoaded && state.bookmarkId != null;
        return IconButton(
          icon: Icon(
            Icons.delete_outlined,
            semanticLabel: appLocalizations.backupManagerDeleteBookmarkBackup,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    final cubit = BlocProvider.of<_Cubit>(context);

    if (cubit.state.bookmarkId == null) {
      cubit.refresh();
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) =>
            _ProcessCubit()..deleteBookmarks(cubit.state.bookmarkId!),
        child: const _ProcessAllDialog(),
      ),
    ).then((value) => cubit.refresh());
  }
}
