import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../common_components/common_back_button.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_progress_bar_bloc.dart';
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
        body: Column(
          children: [
            BlocBuilder<ReaderProgressBarCubit, ReaderProgressBarState>(
              builder: (BuildContext context, ReaderProgressBarState state) {
                return LinearProgressIndicator(
                  value: state.currentScrollY / state.maxScrollY,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                );
              },
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollNotification) =>
                    _onScrollNotification(context, scrollNotification),
                child: CustomScrollView(
                  controller: cubit.scrollController,
                  slivers: const [
                    ReaderSliverContent(),
                  ],
                ),
              ),
            ),
            Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
          ],
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

  bool _onScrollNotification(BuildContext context, ScrollNotification scrollNotification) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    final ReaderProgressBarCubit progressBarCubit = BlocProvider.of<ReaderProgressBarCubit>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final double maxScrollHeight = scrollNotification.metrics.extentTotal;
    final double currentScrollY = scrollNotification.metrics.pixels.clamp(0.0, maxScrollHeight);

    cubit.currentArea = currentScrollY * screenSize.width;
    progressBarCubit.update(currentScrollY, scrollNotification.metrics.maxScrollExtent);

    if (scrollNotification is ScrollEndNotification) {
      if (cubit.state.readerSettings.autoSave) {
        cubit.saveBookmark();
      }
    }

    return true;
  }
}
