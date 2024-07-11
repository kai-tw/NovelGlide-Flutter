import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../common_components/common_loading.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_progress_bar_bloc.dart';
import 'bloc/reader_state.dart';
import 'reader_sliver_content.dart';
import 'widgets/reader_progress_bar.dart';

class ReaderBody extends StatelessWidget {
  const ReaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReaderProgressBar(),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) =>
                _onScrollNotification(context, scrollNotification),
            child: CustomScrollView(
              controller: BlocProvider.of<ReaderCubit>(context).scrollController,
              slivers: [
                BlocBuilder<ReaderCubit, ReaderState>(
                    buildWhen: (previous, current) => previous.code != current.code,
                    builder: (BuildContext context, ReaderState state) {
                      switch (state.code) {
                        case ReaderStateCode.loaded:
                          return const ReaderSliverContent();
                        default:
                          return const CommonSliverLoading();
                      }
                    }
                )
              ],
            ),
          ),
        ),
        Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
      ],
    );
  }

  bool _onScrollNotification(BuildContext context, ScrollNotification scrollNotification) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    final ReaderProgressBarCubit progressBarCubit = BlocProvider.of<ReaderProgressBarCubit>(context);

    if (cubit.state.code != ReaderStateCode.loaded) {
      // The content is not loaded yet.
      return true;
    }

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