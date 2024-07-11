import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/window_class.dart';
import 'bloc/toc_bloc.dart';
import 'view/toc_scaffold_compact_view.dart';
import 'view/toc_scaffold_medium_view.dart';

class TocScaffold extends StatelessWidget {
  const TocScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
    final Widget scaffold;

    switch (windowClass) {
      case WindowClass.compact:
        scaffold = const TocScaffoldCompactView();
        break;
      default:
        scaffold = const TocScaffoldMediumView();
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        Navigator.of(context).pop(cubit.state.isDirty);
      },
      child: scaffold,
    );
  }
}
