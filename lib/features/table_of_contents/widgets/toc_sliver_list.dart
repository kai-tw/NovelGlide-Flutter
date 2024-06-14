import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_list_empty.dart';
import '../../common_components/common_loading.dart';
import '../bloc/toc_bloc.dart';
import '../chapter_list/toc_sliver_chapter_list.dart';

class TOCSliverList extends StatelessWidget {
  const TOCSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TOCCubit>(context).refresh();
    return BlocBuilder<TOCCubit, TOCState>(
      builder: (BuildContext context, TOCState state) {
        switch (state.code) {
          case TOCStateCode.loading:
            return const CommonSliverLoading();

          case TOCStateCode.normal:
            return const TOCSliverChapterList();

          default:
            return const CommonSliverListEmpty();
        }
      },
    );
  }
}