import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/bookmark_data.dart';
import 'common_list_tile.dart';

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

    return CommonListTile(
      title: _bookmarkObject.bookName,
      subtitle: appLocalizations.chapterLabelFunction(_bookmarkObject.chapterNumber),
      description: savedTimeString,
      leading: leading ?? Icon(
        Icons.bookmark_rounded,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      color: color,
    );
  }
}