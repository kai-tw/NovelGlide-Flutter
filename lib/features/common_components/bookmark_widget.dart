import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/bookmark_data.dart';

class BookmarkWidget extends StatelessWidget {
  final BookmarkData _bookmarkObject;
  final Widget? leading;
  final Color? color;

  const BookmarkWidget(this._bookmarkObject, {super.key, this.leading, this.color});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final int daysPassed = _bookmarkObject.daysPassed;
    String savedTimeString = "";

    switch (daysPassed) {
      case 0:
        savedTimeString = appLocalizations.savedTimeToday;
        break;
      case 1:
        savedTimeString = appLocalizations.savedTimeYesterday;
        break;
      default:
        savedTimeString = appLocalizations.savedTimeOthersFunction(daysPassed);
    }

    savedTimeString = appLocalizations.savedTimeFunction(savedTimeString);

    return Row(
      children: [
        leading ?? Icon(
          Icons.bookmark_rounded,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _bookmarkObject.bookName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
                ),
                Text(
                  appLocalizations.chapterLabelFunction(_bookmarkObject.chapterNumber),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
                ),
                Text(
                  savedTimeString,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}