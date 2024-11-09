part of '../../backup_manager_google_drive.dart';

class _ProcessAllButtonBar extends StatelessWidget {
  const _ProcessAllButtonBar();

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<_ProcessCubit, _ProcessState>(
            buildWhen: (previous, current) =>
                previous.isLibraryRunning != current.isLibraryRunning ||
                previous.isCollectionRunning != current.isCollectionRunning ||
                previous.isBookmarkRunning != current.isBookmarkRunning ||
                previous.libraryStep != current.libraryStep ||
                previous.collectionStep != current.collectionStep ||
                previous.bookmarkStep != current.bookmarkStep,
            builder: (context, state) {
              final isLibraryFinished = !state.isLibraryRunning ||
                  state.libraryStep == _ProcessStep.done;
              final isCollectionFinished = !state.isCollectionRunning ||
                  state.collectionStep == _ProcessStep.done;
              final isBookmarkFinished = !state.isBookmarkRunning ||
                  state.bookmarkStep == _ProcessStep.done;
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
