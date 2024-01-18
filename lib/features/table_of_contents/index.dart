import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_process.dart';
import '../../shared/sliver_list_empty.dart';
import '../../shared/sliver_loading.dart';
import 'bloc/toc_bloc.dart';
import 'sliver_app_bar_default.dart';
import 'sliver_book_name.dart';
import 'sliver_chapter_list.dart';
import 'sliver_cover_banner.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: bookObject,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TOCCubit(bookObject)),
        ],
        child: BlocBuilder<TOCCubit, TOCState>(
          builder: (BuildContext context, TOCState state) {
            List<Widget> sliverList = [];

            sliverList.add(TOCSliverAppBar(bookObject));
            sliverList.add(TOCSliverCoverBanner(bookObject));
            sliverList.add(TOCSliverBookName(bookObject));

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
                sliverList.add(TOCSliverChapterList(bookObject));
                break;
            }

            return Scaffold(
              body: CustomScrollView(
                slivers: sliverList,
              ),
            );
          },
        ),
      ),
    );
  }
}
