import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import 'bloc/reader_cubit.dart';
import 'widgets/reader_overlap_widget.dart';

class ReaderBody extends StatelessWidget {
  const ReaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return Stack(
      children: [
        /// Reader WebView
        Column(
          children: [
            Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
            Expanded(
              child: WebViewWidget(controller: cubit.webViewHandler.controller),
            ),
            // const ReaderPagination(),
          ],
        ),

        /// Reader Overlay (including loading and searching widgets.)
        const Positioned.fill(
          child: ReaderOverlapWidget(),
        ),
      ],
    );
  }
}
