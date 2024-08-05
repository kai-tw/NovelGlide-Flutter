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

    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: leading ?? const Icon(Icons.bookmark_rounded),
        title: Text(_bookmarkObject.bookName),
        subtitle: Text("${appLocalizations.chapterLabel(_bookmarkObject.chapterNumber)} / $savedTimeString"),
        textColor: color,
        iconColor: color,
      ),
    );
  }
}
