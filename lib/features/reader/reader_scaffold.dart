import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import 'bloc/reader_cubit.dart';
import 'view/reader_scaffold_compact_view.dart';
import 'view/reader_scaffold_medium_view.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    final Widget scaffold;

    switch (windowClass) {
      case WindowClass.compact:
        scaffold = const ReaderScaffoldCompactView();
        break;
      default:
        scaffold = const ReaderScaffoldMediumView();
        break;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        BlocProvider.of<ReaderCubit>(context).autoSaveBookmark();
        Navigator.of(context).pop();
      },
      child: scaffold,
    );
  }
}