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
            double maxScrollHeight = scrollNotification.metrics.extentTotal;
            double currentScrollY = scrollNotification.metrics.pixels.clamp(0.0, maxScrollHeight);
            readerCubit.area = currentScrollY * MediaQuery.of(context).size.width;
          }
          return false;
        },
        child: CustomScrollView(
          controller: readerCubit.scrollController,
          slivers: const [
            ReaderSliverAppBar(),
            ReaderSliverTitle(),
            ReaderSliverContent(),
          ],
        ),
      ),
      bottomNavigationBar: const ReaderNavBar(),
    );
  }
}
