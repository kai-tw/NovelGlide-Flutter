import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_cubit.dart';
import 'nav_bar.dart';
import 'sliver_app_bar.dart';
import 'sliver_content.dart';
import 'sliver_title.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context)..initialize();
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            readerCubit.setMaxScrollY(scrollNotification.metrics.extentTotal);
            readerCubit.setScrollY(scrollNotification.metrics.pixels);
          }
          return false;
        },
        child: Stack(
          children: [
            CustomScrollView(
              controller: readerCubit.scrollController,
              slivers: const [
                ReaderSliverAppBar(),
                ReaderSliverTitle(),
                ReaderSliverContent(),
              ],
            )
          ]
        ),
      ),
      bottomNavigationBar: const ReaderNavBar(),
    );
  }
}
