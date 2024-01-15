import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:novelglide/ui/components/view_list/bloc.dart';

import '../bloc/chapter_list_bloc.dart';
import 'chapter_app_bar.dart';
import 'chapter_item.dart';

class ChapterList extends StatelessWidget {
  const ChapterList({super.key, required this.bookName});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChapterListCubit(),
      child: BlocBuilder<ChapterListCubit, ViewListState>(
        builder: (BuildContext context, ViewListState state) {
          return Scaffold(
            body: SlidableAutoCloseBehavior(
              child: CustomScrollView(
                slivers: [
                  ChapterListAppBar(bookName),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ChapterItem((index + 1).toString());
                      },
                      childCount: 100,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
