import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../common_components/common_loading.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';
import 'widgets/reader_progress_bar.dart';

class ReaderBody extends StatelessWidget {
  const ReaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = context.read<ReaderCubit>();
    return Column(
      children: [
        const ReaderProgressBar(),
        Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
        Expanded(
          child: BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              switch (state.code) {
                case ReaderStateCode.loaded:
                  return WebViewWidget(controller: cubit.webViewController);
                default:
                  return const Center(
                    child: CommonLoading(),
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
