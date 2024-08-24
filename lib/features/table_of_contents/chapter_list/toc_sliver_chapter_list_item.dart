import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/chapter_data.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';

class TocSliverChapterListItem extends StatelessWidget {
  final ChapterData chapterData;

  const TocSliverChapterListItem(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
      child: BlocBuilder<TocCubit, TocState>(
        buildWhen: (previous, current) => previous.bookmarkData?.startCfi != current.bookmarkData?.startCfi,
        builder: (BuildContext context, TocState state) {
          return ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => ReaderWidget(cubit.bookData, gotoDestination: chapterData.fileName)))
                  .then((_) => cubit.refresh());
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            leading: const Icon(Icons.numbers_rounded),
            title: Text(chapterData.title),
          );
        },
      ),
    );
  }
}
