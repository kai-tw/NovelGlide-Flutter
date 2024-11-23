part of '../reader.dart';

class _GestureDetector extends StatelessWidget {
  const _GestureDetector();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (prev, curr) => prev.readerSettings != curr.readerSettings,
      builder: (context, state) {
        if (state.readerSettings.gestureDetection) {
          return GestureDetector(
            /// Swipe to prev/next page
            onHorizontalDragStart: cubit._gestureHandler.onStart,
            onHorizontalDragEnd: cubit._gestureHandler.onEnd,
            onHorizontalDragCancel: cubit._gestureHandler.onCancel,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
