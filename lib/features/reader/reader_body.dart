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
    BlocProvider.of<ReaderCubit>(context).scrollController.addListener(() => _onScroll(context));
    return Column(
      children: [
        const ReaderProgressBar(),
        Expanded(
          child: Scrollbar(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
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
                  },
                ),
              ],
            ),
          ),
        ),
        Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
      ],
    );
  }

  void _onScroll(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    final ReaderProgressBarCubit progressBarCubit = BlocProvider.of<ReaderProgressBarCubit>(context);

    if (cubit.state.code != ReaderStateCode.loaded) {
      // The content is not loaded yet.
      return;
    }

    final double currentScrollY = cubit.scrollController.position.pixels;
    final double maxScrollExtent = cubit.scrollController.position.maxScrollExtent;
    progressBarCubit.setState(currentScrollY, maxScrollExtent);

    return;
  }
}
