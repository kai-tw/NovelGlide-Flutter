import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ad_center/bottom_ad_wrapper.dart';
import '../common_components/common_back_button.dart';
import 'bloc/reader_cubit.dart';
import 'reader_nav_bar.dart';
import 'reader_sliver_content.dart';
import 'widgets/reader_title.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _onExit(context);
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CommonBackButton(onPressed: () => _onExit(context)),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          title: const ReaderTitle(),
        ),
        body: BottomAdWrapper(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) =>
                _onScrollNotification(context, scrollNotification, cubit),
            child: CustomScrollView(
              controller: cubit.scrollController,
              slivers: const [
                ReaderSliverContent(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const ReaderNavBar(),
      ),
    );
  }

  void _onExit(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    if (cubit.state.readerSettings.autoSave) {
      cubit.saveBookmark();
    }
  }

  bool _onScrollNotification(BuildContext context, ScrollNotification scrollNotification, ReaderCubit cubit) {
    double maxScrollHeight = scrollNotification.metrics.extentTotal;
    double currentScrollY = scrollNotification.metrics.pixels.clamp(0.0, maxScrollHeight);
    cubit.currentArea = currentScrollY * MediaQuery.of(context).size.width;

    if (scrollNotification is ScrollEndNotification) {
      if (cubit.state.readerSettings.autoSave) {
        cubit.saveBookmark();
      }
    }

    return true;
  }
}
