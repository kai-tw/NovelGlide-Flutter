import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderGestureDetector extends StatelessWidget {
  const ReaderGestureDetector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (prev, curr) => prev.readerSettings != curr.readerSettings,
      builder: (context, state) {
        if (state.readerSettings.gestureDetection) {
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
    );
  }
}
