part of '../reader.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    final _ReaderCubit cubit = BlocProvider.of<_ReaderCubit>(context);
    return Stack(
      children: [
        /// Reader WebView
        Column(
          children: [
            Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
            Expanded(
              child:
                  WebViewWidget(controller: cubit._webViewHandler.controller),
            ),
            // const ReaderPagination(),
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
