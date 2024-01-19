import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/chapter_object.dart';

class ReaderSliverTitle extends StatelessWidget {
  const ReaderSliverTitle(this.chapterObject, {super.key});

  final ChapterObject chapterObject;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        AppLocalizations.of(context)!.chapter_label(chapterObject.ordinalNumber),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
