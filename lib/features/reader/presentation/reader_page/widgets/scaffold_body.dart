part of '../reader.dart';

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody();

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return Column(
      children: <Widget>[
        const Advertisement(
          unitId: AdUnitId.reader,
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              /// Reader WebView
              Positioned.fill(
                child: BlocBuilder<ReaderCubit, ReaderState>(
                  buildWhen: (ReaderState previous, ReaderState current) =>
                      previous.code != current.code,
                  builder: (BuildContext context, ReaderState state) {
                    return state.code.isInitial
                        ? const SizedBox.shrink()
                        : _buildReader(cubit);
                  },
                ),
              ),

              /// Reader Overlay (including loading and searching widgets.)
              const Positioned.fill(
                child: _OverlapWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReader(ReaderCubit cubit) {
    return Column(
      children: <Widget>[
        const _Breadcrumb(),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,

            /// Swipe to prev/next page
            onHorizontalDragStart: cubit.gestureHandler!.onStart,
            onHorizontalDragEnd: cubit.gestureHandler!.onEnd,
            onHorizontalDragCancel: cubit.gestureHandler!.onCancel,
            child: WebViewWidget(
              controller: cubit.webViewHandler!.controller,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
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
    );
  }
}
