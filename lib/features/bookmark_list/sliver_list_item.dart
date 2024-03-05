import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../shared/bookmark_object.dart';

class BookmarkSliverListItem extends StatelessWidget {
  const BookmarkSliverListItem(this._bookmarkObject, {super.key});

  final BookmarkObject _bookmarkObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        groupTag: "BookmarkSliverListItem",
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              icon: Icons.delete_outline_rounded,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            // Navigate to reader.
            print(_bookmarkObject);
          },
          child: Row(
            children: [
              const Icon(Icons.bookmark_rounded),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _bookmarkObject.bookName,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.chapter_label(_bookmarkObject.chapterNumber),
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.last_read_days(_bookmarkObject.daysPassed),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
