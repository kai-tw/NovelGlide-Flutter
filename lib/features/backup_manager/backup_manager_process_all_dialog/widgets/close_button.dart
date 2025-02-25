part of '../backup_manager_process_all_dialog.dart';

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<ProcessAllDialogCubit, BackupManagerProcessAllDialogState>(
            buildWhen: (previous, current) =>
                previous.isLibraryRunning != current.isLibraryRunning ||
                previous.isCollectionRunning != current.isCollectionRunning ||
                previous.isBookmarkRunning != current.isBookmarkRunning ||
                previous.libraryStep != current.libraryStep ||
                previous.collectionStep != current.collectionStep ||
                previous.bookmarkStep != current.bookmarkStep,
            builder: (context, state) {
              final isLibraryFinished = !state.isLibraryRunning ||
                  state.libraryStep == BackupManagerProcessStepCode.done;
              final isCollectionFinished = !state.isCollectionRunning ||
                  state.collectionStep == BackupManagerProcessStepCode.done;
              final isBookmarkFinished = !state.isBookmarkRunning ||
                  state.bookmarkStep == BackupManagerProcessStepCode.done;
              final isFinished = isLibraryFinished &&
                  isCollectionFinished &&
                  isBookmarkFinished;
              return TextButton.icon(
                onPressed:
                    isFinished ? () => Navigator.of(context).pop() : null,
                icon: const Icon(Icons.close_rounded),
                label: Text(AppLocalizations.of(context)!.generalClose),
              );
            }),
      ],
    );
  }
}
