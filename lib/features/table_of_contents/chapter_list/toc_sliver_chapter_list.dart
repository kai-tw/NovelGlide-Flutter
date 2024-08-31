import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/loading_state_code.dart';
import '../../common_components/common_list_empty.dart';
import '../../common_components/common_loading.dart';
import '../bloc/toc_bloc.dart';
import 'toc_sliver_chapter_list_item.dart';

class TocSliverChapterList extends StatelessWidget {
  const TocSliverChapterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TocCubit, TocState>(
      buildWhen: (previous, current) => previous.code != current.code || previous.chapterList != current.chapterList,
      builder: (BuildContext context, TocState state) {
        switch (state.code) {
          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();

          case LoadingStateCode.loaded:
            if (state.chapterList.isEmpty) {
              return const CommonSliverListEmpty();
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Semantics(
                      label: AppLocalizations.of(context)!.accessibilityTocListItem,
                      onTapHint: AppLocalizations.of(context)!.accessibilityTocListItemOnTap,
                      onLongPressHint: AppLocalizations.of(context)!.accessibilityTocListItemOnLongPress,
                      child: TocSliverChapterListItem(state.chapterList[index]),
                    );
                  },
                  childCount: state.chapterList.length,
                ),
              );
            }
        }
      },
    );
  }
}
