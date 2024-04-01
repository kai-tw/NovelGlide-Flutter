import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../add_chapter/add_chapter_callee_add_button.dart';
import 'bloc/toc_bloc.dart';
import 'toc_sliver_book_name.dart';
import 'toc_sliver_cover_banner.dart';
import 'toc_sliver_list.dart';
import 'toc_app_bar.dart';

class TOCScaffold extends StatelessWidget {
  const TOCScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    return Scaffold(
      appBar: const TOCAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => cubit.refresh(),
        child: const SlidableAutoCloseBehavior(
          child: CustomScrollView(
            slivers: [
              TOCSliverCoverBanner(),
              TOCSliverBookName(),
              TOCSliverList(),
            ],
          ),
        ),
      ),
      floatingActionButton: AddChapterCalleeAddButton(
        cubit.bookObject.name,
        onPopBack: (isSuccess) {
          if (isSuccess == true) {
            cubit.refresh(isForce: true);
          }
        },
      ),
    );
  }
}
