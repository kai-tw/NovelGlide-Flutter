import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../shared_components/common_loading.dart';
import '../../../../shared_components/shared_list/shared_list.dart';
import '../../../domain/entities/book.dart';
import '../cubit/toc_cubit.dart';
import '../cubit/toc_state.dart';
import 'toc_list_item.dart';

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
          return TocListItem(
            bookData: bookData,
            bookChapter: state.chapterList[index].chapterData,
            chapterNestedLevel: state.chapterList[index].nestedLevel,
            bookmark: state.bookmarkData,
          );
        },
        childCount: state.chapterList.length,
      ),
    );
  }
}
