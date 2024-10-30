import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data_model/bookmark_data.dart';

class BookmarkWidget extends StatelessWidget {
  final BookmarkData _bookmarkData;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? backgroundColor;

  const BookmarkWidget(this._bookmarkData,
      {super.key,
      this.leading,
      this.color,
      this.backgroundColor,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final int daysPassed = _bookmarkData.daysPassed;
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubicEmphasized,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          leading: leading ??
              const Padding(
                padding: EdgeInsets.only(right: 14.0),
                child: Icon(Icons.bookmark_rounded),
              ),
          trailing: trailing,
          title: Text(_bookmarkData.bookName),
          subtitle: Text('${_bookmarkData.chapterTitle}\n$savedTimeString'),
          textColor: color,
          iconColor: color,
        ),
      ),
    );
  }
}
