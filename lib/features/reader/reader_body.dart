import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../common_components/common_loading.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';
import 'search/reader_search.dart';
import 'widgets/reader_overlap_widget.dart';
import 'widgets/reader_pagination.dart';

class ReaderBody extends StatelessWidget {
  const ReaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = context.read<ReaderCubit>();
    cubit.sendThemeData(Theme.of(context));
    return Stack(
      children: [
        /// Reader WebView
        Column(
          children: [
            Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
            Expanded(
              child: WebViewWidget(controller: cubit.webViewController),
            ),
            const ReaderPagination(),
          ],
        ),

        /// Reader Overlay (including loading and searching widgets.)
        Positioned.fill(
          child: BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) => previous.code != current.code,
            builder: (context, state) {
              Widget child;

              switch (state.code) {
                case ReaderStateCode.loaded:
                  child = const SizedBox.shrink();
                  break;

                case ReaderStateCode.loading:
                  child = const ReaderOverlapWidget(
                    children: [
                      Center(
                        child: CommonLoading(),
                      ),
                    ],
                  );

                case ReaderStateCode.search:
                  child = const ReaderSearch();
                  break;
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
                        .chain(CurveTween(curve: Curves.easeInOut))
                        .animate(animation),
                    child: child,
                  ),
                ),
                child: child,
              );
            },
          ),
        ),

        /// Gesture Detector overlay
        Positioned.fill(
          child: BlocBuilder<ReaderCubit, ReaderState>(
            buildWhen: (previous, current) =>
                previous.code != current.code || previous.readerSettings != current.readerSettings,
            builder: (context, state) {
              if (state.code == ReaderStateCode.loaded && state.readerSettings.gestureDetection) {
                return GestureDetector(
                  /// Swipe to prev/next page
                  onHorizontalDragStart: cubit.gestureHandler.onStart,
                  onHorizontalDragEnd: cubit.gestureHandler.onEnd,
                  onHorizontalDragCancel: cubit.gestureHandler.onCancel,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
