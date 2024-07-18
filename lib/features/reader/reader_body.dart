import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../common_components/common_loading.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';
import 'reader_sliver_content.dart';
import 'widgets/reader_progress_bar.dart';

class ReaderBody extends StatelessWidget {
  const ReaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);

    return Column(
      children: [
        const ReaderProgressBar(),
        Expanded(
          child: BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              switch (state.code) {
                case ReaderStateCode.loaded:
                  return PageStorage(
                    bucket: cubit.bucket,
                    child: Scrollbar(
                      controller: cubit.scrollController,
                      child: CustomScrollView(
                        key: const PageStorageKey('reader-body-scrollview'),
                        physics: const BouncingScrollPhysics(),
                        controller: cubit.scrollController,
                        slivers: const [
                          ReaderSliverContent(),
                        ],
                      ),
                    ),
                  );
                default:
                  return const Center(
                    child: CommonLoading(),
                  );
              }
            },
          ),
        ),
        Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
      ],
    );
  }
}
