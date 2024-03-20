import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_object.dart';
import '../../shared/sliver_list_empty.dart';
import '../../shared/sliver_loading.dart';
import 'bloc/toc_bloc.dart';
import 'toc_sliver_app_bar.dart';
import 'toc_sliver_book_name.dart';
import 'toc_sliver_chapter_list.dart';
import 'toc_sliver_cover_banner.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TOCCubit(bookObject),
      child: BlocBuilder<TOCCubit, TOCState>(
        builder: (BuildContext context, TOCState state) {
          List<Widget> sliverList = [
            const TOCSliverAppBar(),
            const TOCSliverCoverBanner(),
            const TOCSliverBookName(),
          ];

          switch (state.code) {
            case TOCStateCode.unload:
              BlocProvider.of<TOCCubit>(context).refresh();
              break;
            case TOCStateCode.loading:
              sliverList.add(const CommonSliverLoading());
              break;
            case TOCStateCode.empty:
              sliverList.add(const CommonSliverListEmpty());
              break;
            case TOCStateCode.normal:
              sliverList.add(const TOCSliverChapterList());
              break;
          }

          return Scaffold(
            body: CustomScrollView(
              slivers: sliverList,
            ),
          );
        },
      ),
    );
  }
}
