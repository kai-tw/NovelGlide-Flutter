import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/bookmark_list_bloc.dart';

class BookmarkListDeleteButton extends StatelessWidget {
  const BookmarkListDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context);
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: const Icon(Icons.delete_forever_rounded, size: 48.0),
              title: Text(appLocalizations.alertDialogDeleteBookmarkTitle),
              content: Text(appLocalizations.alertDialogDeleteBookmarkDescription),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(appLocalizations.cancel),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cubit.deleteSelectedBookmarks();
                  },
                  child: Text(
                    appLocalizations.yes,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Theme.of(context).colorScheme.error,
        fixedSize: const Size(double.infinity, 56.0),
        minimumSize: const Size(double.infinity, 56.0),
      ),
      icon: const Icon(Icons.delete_rounded),
      label: BlocBuilder<BookmarkListCubit, BookmarkListState>(
        buildWhen: (previous, current) => previous.selectedBookmarks != current.selectedBookmarks,
        builder: (context, state) {
          return Text(appLocalizations.bookmarkListDeleteNumberOfSelectedBookmarks(state.selectedBookmarks.length));
        },
      ),
    );
  }
}