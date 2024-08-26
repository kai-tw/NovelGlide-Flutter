import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';
import 'view/reader_scaffold_compact_view.dart';
import 'view/reader_scaffold_medium_view.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    Widget child;

    switch (windowClass) {
      case WindowClass.compact:
        child = const ReaderScaffoldCompactView();
        break;

      default:
        child = const ReaderScaffoldMediumView();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        switch (cubit.state.code) {
          case ReaderStateCode.search:
            cubit.closeSearch();
            break;

          default:
            Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }
}