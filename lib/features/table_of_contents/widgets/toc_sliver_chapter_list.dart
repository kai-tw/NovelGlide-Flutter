import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../../data/chapter_data.dart';
import '../../common_components/common_list_empty.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';

class TocSliverChapterList extends StatelessWidget {
  final BookData bookData;

  const TocSliverChapterList({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    if (bookData.chapterList?.isEmpty ?? true) {
      return const CommonSliverListEmpty();
    } else {
      final TocCubit cubit = BlocProvider.of<TocCubit>(context);
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final ChapterData chapterData = bookData.chapterList![index];

            return Semantics(
              label: AppLocalizations.of(context)!.accessibilityTocListItem,
              onTapHint: AppLocalizations.of(context)!.accessibilityTocListItemOnTap,
              onLongPressHint: AppLocalizations.of(context)!.accessibilityTocListItemOnLongPress,
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => ReaderWidget(bookData, gotoDestination: chapterData.fileName)))
                      .then((_) => cubit.refresh());
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                leading: const Icon(Icons.numbers_rounded),
                title: Text(chapterData.title),
              ),
            );
          },
          childCount: bookData.chapterList!.length,
        ),
      );
    }
  }
}
