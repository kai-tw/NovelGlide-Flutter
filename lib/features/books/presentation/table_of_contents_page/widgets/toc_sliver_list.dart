import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../bookmark_service/bookmark_service.dart';
import '../../../../reader/presentation/reader_page/reader.dart';
import '../../../../shared_components/common_loading.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_chapter.dart';
import '../cubit/toc_cubit.dart';
import '../cubit/toc_state.dart';

class TocSliverList extends StatelessWidget {
  const TocSliverList({super.key, required this.bookData});

  final Book bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<TocCubit, TocState>(
      buildWhen: (TocState previous, TocState current) =>
          previous.code != current.code ||
          previous.chapterList != current.chapterList ||
          previous.bookmarkData != current.bookmarkData,
      builder: (BuildContext context, TocState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
          case LoadingStateCode.backgroundLoading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.chapterList.isEmpty) {
              return SharedListSliverEmpty(
                title: appLocalizations.tocNoChapter,
              );
            } else {
              return _buildList(context, state);
            }
        }
      },
    );
  }

  Widget _buildList(BuildContext context, TocState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final BookChapter chapterData = state.chapterList[index].chapterData;
          final int nestedLevel = state.chapterList[index].nestedLevel;
          final BookmarkData? bookmarkData = state.bookmarkData;
          final bool isBookmarked =
              // TODO(kai): Change to identifier.
              bookmarkData?.chapterFileName == chapterData.identifier;
          final ThemeData themeData = Theme.of(context);

          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ReaderWidget(
                    // TODO(kai): Change to identifier.
                    bookData: bookData,
                    bookIdentifier: bookData.identifier,
                    destination: chapterData.identifier,
                  ),
                ),
              );
            },
            dense: true,
            contentPadding: EdgeInsets.only(
              left: 12.0 + 16 * nestedLevel,
              right: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            leading: Icon(
              isBookmarked ? Icons.bookmark_rounded : Icons.numbers_rounded,
              color: isBookmarked ? themeData.colorScheme.secondary : null,
              size: 20.0,
            ),
            title: Text(
              chapterData.title,
              style: themeData.textTheme.bodyLarge,
            ),
          );
        },
        childCount: state.chapterList.length,
      ),
    );
  }
}
