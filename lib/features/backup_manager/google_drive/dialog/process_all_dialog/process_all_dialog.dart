part of '../../backup_manager_google_drive.dart';

class _ProcessAllDialog extends StatelessWidget {
  const _ProcessAllDialog();

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: kDebugMode,
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProcessAllLibraryTile(),
              _ProcessAllCollectionTile(),
              _ProcessAllBookmarkTile(),
              _ProcessAllButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}
