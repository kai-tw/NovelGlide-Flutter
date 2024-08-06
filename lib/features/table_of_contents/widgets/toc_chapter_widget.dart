import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/chapter_data.dart';

class TocChapterWidget extends StatelessWidget {
  final ChapterData chapterData;
  final bool isBookmarked;
  final void Function()? onPressed;

  const TocChapterWidget({super.key, required this.chapterData, required this.isBookmarked, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final String localizedOrdinalNum = AppLocalizations.of(context)!.chapterLabel(chapterData.ordinalNumber);
    final double iconSize = IconTheme.of(context).size ?? 24.0;
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        disabledForegroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      icon: Icon(
        isBookmarked ? Icons.bookmark_rounded : Icons.numbers_rounded,
        size: MediaQuery.of(context).textScaler.scale(iconSize),
        color: isBookmarked ? Theme.of(context).colorScheme.error : null,
      ),
      label: Text(
        "$localizedOrdinalNum - ${chapterData.title}",
        textAlign: TextAlign.left,
      ),
    );
  }
}