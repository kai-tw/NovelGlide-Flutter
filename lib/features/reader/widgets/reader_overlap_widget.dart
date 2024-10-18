import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_loading.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';
import '../search/reader_search.dart';
import 'reader_gesture_detector.dart';

class ReaderOverlapWidget extends StatelessWidget {
  const ReaderOverlapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        Widget child;

        switch (state.code) {
          case ReaderStateCode.loaded:
            child = const ReaderGestureDetector();
            break;

          case ReaderStateCode.loading:
            child = Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: const Center(
                child: CommonLoading(),
              ),
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
}
