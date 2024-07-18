import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/bookmark_manager_bloc.dart';

class BookmarkManagerDeleteButton extends StatelessWidget {
  const BookmarkManagerDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkManagerCubit, BookmarkManagerState>(
      buildWhen: (previous, current) => previous.selectedBookmarks != current.selectedBookmarks,
      builder: (BuildContext context, BookmarkManagerState state) {
        return FloatingActionButton.extended(
          onPressed: () {
            final BookmarkManagerCubit cubit = BlocProvider.of<BookmarkManagerCubit>(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  icon: const Icon(Icons.delete_forever_rounded, size: 48.0),
                  title: Text(AppLocalizations.of(context)!.alertDialogDeleteBookmarkTitle),
                  content: Text(AppLocalizations.of(context)!.alertDialogDeleteBookmarkDescription),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        cubit.deleteSelectedBookmarks();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.delete_rounded),
          label: Text(AppLocalizations.of(context)!
              .bookmarkManagerDeleteNumberOfSelectedBookmarks(state.selectedBookmarks.length)),
          backgroundColor: Theme.of(context).colorScheme.error,
          foregroundColor: Theme.of(context).colorScheme.onError,
        );
      },
    );
  }
}