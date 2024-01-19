import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/book_object.dart';
import 'bloc/toc_bloc.dart';

class TOCSliverChapterList extends StatelessWidget {
  const TOCSliverChapterList(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TOCCubit, TOCState>(
      builder: (BuildContext context, TOCState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              int chapterNumber = state.chapterMap.keys.elementAt(index);
              String chapterTitle = state.chapterMap.values.elementAt(index);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: Text(
                    '${AppLocalizations.of(context)!.chapter_label(chapterNumber)} - $chapterTitle',
                    textAlign: TextAlign.left,
                  ),
                ),
              );
            },
            childCount: state.chapterMap.length,
          ),
        );
      },
    );
  }
}
