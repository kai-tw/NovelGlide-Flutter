part of '../backup_service_process_dialog.dart';

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      children: <Widget>[
        // Library
        BlocBuilder<BackupServiceProcessLibraryCubit,
            BackupServiceProcessItemState>(
          builder: (BuildContext context,
                  BackupServiceProcessItemState libraryState) =>

              // Bookmark
              BlocBuilder<BackupServiceProcessBookmarkCubit,
                  BackupServiceProcessItemState>(
            builder: (BuildContext context,
                    BackupServiceProcessItemState bookmarkState) =>

                // Collection
                BlocBuilder<BackupServiceProcessCollectionCubit,
                    BackupServiceProcessItemState>(
              builder: (BuildContext context,
                      BackupServiceProcessItemState collectionState) =>
                  TextButton.icon(
                onPressed: libraryState.isRunning ||
                        bookmarkState.isRunning ||
                        collectionState.isRunning
                    ? null
                    : () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
                label: Text(AppLocalizations.of(context)!.generalClose),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
