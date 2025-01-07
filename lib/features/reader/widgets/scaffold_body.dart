part of '../reader.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return Stack(
      children: [
        /// Reader WebView
        Column(
          children: [
            Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
            const _Breadcrumb(),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,

                /// Swipe to prev/next page
                onHorizontalDragStart: cubit._gestureHandler.onStart,
                onHorizontalDragEnd: cubit._gestureHandler.onEnd,
                onHorizontalDragCancel: cubit._gestureHandler.onCancel,
                child: WebViewWidget(
                  controller: cubit._webViewHandler.controller,
                  gestureRecognizers: {
                    Factory<LongPressGestureRecognizer>(
                      () => LongPressGestureRecognizer(
                        duration: const Duration(milliseconds: 100),
                      ),
                    ),
                  },
                ),
              ),
            ),
            const _Pagination(),
          ],
        ),

        /// Reader Overlay (including loading and searching widgets.)
        const Positioned.fill(
          child: _OverlapWidget(),
        ),
      ],
    );
  }
}
