import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_cubit.dart';
import 'reader_nav_bar.dart';
import 'reader_app_bar.dart';
import 'reader_sliver_content.dart';
import 'reader_sliver_title.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context)..initialize();
    return PopScope(
      canPop: !cubit.state.readerSettings.autoSave,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        cubit.dispose();
      },
      child: Scaffold(
        appBar: const ReaderAppBar(),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            if (scrollNotification is ScrollEndNotification) {
              double maxScrollHeight = scrollNotification.metrics.extentTotal;
              double currentScrollY = scrollNotification.metrics.pixels.clamp(0.0, maxScrollHeight);
              cubit.currentArea = currentScrollY * MediaQuery.of(context).size.width;
            }

            if (cubit.state.readerSettings.autoSave) {
              cubit.saveBookmark();
            }

            return true;
          },
          child: CustomScrollView(
            controller: cubit.scrollController,
            slivers: const [
              ReaderSliverTitle(),
              ReaderSliverContent(),
            ],
          ),
        ),
        bottomNavigationBar: const ReaderNavBar(),
      ),
    );
  }
}
