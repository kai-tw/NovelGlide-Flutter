import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../common_components/common_loading.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';

class ReaderBody extends StatelessWidget {
  const ReaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = context.read<ReaderCubit>();
    cubit.sendThemeData(Theme.of(context));
    return Column(
      children: [
        Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
        Expanded(
          child: Stack(
            children: [
              WebViewWidget(controller: cubit.webViewController),
              Positioned.fill(
                child: BlocBuilder<ReaderCubit, ReaderState>(
                  buildWhen: (previous, current) => previous.code != current.code,
                  builder: (context, state) {
                    switch (state.code) {
                      case ReaderStateCode.loaded:
                        return const SizedBox.shrink();
                      default:
                        return const Center(
                          child: CommonLoading(),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
