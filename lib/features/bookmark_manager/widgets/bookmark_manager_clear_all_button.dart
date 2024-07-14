import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/bookmark_data.dart';
import '../../../processor/book_processor.dart';

class BookmarkManagerClearAllButton extends StatelessWidget {
  const BookmarkManagerClearAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.alertDialogClearAllBookmarksTitle),
                content: Text(AppLocalizations.of(context)!.alertDialogClearAllBookmarksDescription),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _clearAllBookmarks().then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!.bookmarkManagerClearAllButtonDone),
                          ),
                        );
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: Text(AppLocalizations.of(context)!.delete),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ],
              );
            });
      },
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      icon: const Icon(Icons.delete_forever_rounded),
      label: Text(AppLocalizations.of(context)!.bookmarkManagerClearAllButton),
    );
  }

  Future<void> _clearAllBookmarks() async {
    // Get all books
    final List<String> bookList = BookProcessor.getNameList();
    for (String bookName in bookList) {
      BookmarkData.fromBookName(bookName).clear();
    }
  }
}
