import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/loading_state_code.dart';
import '../../common_components/common_loading.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';
import 'reader_gesture_detector.dart';

class ReaderOverlapWidget extends StatelessWidget {
  const ReaderOverlapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.loadingStateCode != current.loadingStateCode,
      builder: (context, state) {
        Widget child;

        switch (state.code) {
          case LoadingStateCode.loaded:
            child = const ReaderGestureDetector();
            break;

          default:
            child = _buildLoadingWidget(context, state);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0, -1), end: const Offset(0, 0))
                  .chain(CurveTween(curve: Curves.easeInOut))
                  .animate(animation),
              child: child,
            ),
          ),
          child: child,
        );
      },
    );
  }

  Widget _buildLoadingWidget(BuildContext context, ReaderState state) {
    String? title;
    switch (state.loadingStateCode) {
      case ReaderLoadingStateCode.initial:
        title = 'Initializing';
        break;

      case ReaderLoadingStateCode.bookLoading:
        title = 'Loading the book';
        break;

      case ReaderLoadingStateCode.rendering:
        title = 'Rendering';
        break;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Center(
        child: CommonLoading(title: title),
      ),
    );
  }
}
