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
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
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
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        if (cubit.state.readerSettings.autoSave) {
          cubit.saveBookmark();
        }
        Navigator.of(context).pop();
      },
      child: scaffold,
    );
  }
}