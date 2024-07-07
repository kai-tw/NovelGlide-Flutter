import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_list_empty.dart';
import '../../common_components/common_loading.dart';
import '../bloc/toc_bloc.dart';
import '../chapter_list/toc_sliver_chapter_list.dart';

class TocSliverList extends StatelessWidget {
  const TocSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TocCubit>(context).refresh();
    return BlocBuilder<TocCubit, TocState>(
      builder: (BuildContext context, TocState state) {
        switch (state.code) {
          case TocStateCode.loading:
            return const CommonSliverLoading();

          case TocStateCode.normal:
            return const TocSliverChapterList();

          default:
            return const CommonSliverListEmpty();
        }
      },
    );
  }
}