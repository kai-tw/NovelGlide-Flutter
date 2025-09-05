import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../books/presentation/bookshelf/bookshelf_floating_action_button.dart';
import '../cubit/homepage_cubit.dart';

class HomepageFloatingActionButton extends StatelessWidget {
  const HomepageFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(
      buildWhen: (HomepageState previous, HomepageState current) =>
          previous.navItem != current.navItem,
      builder: (BuildContext context, HomepageState state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(2.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            );
          },
          switchInCurve: Curves.easeInOutCubicEmphasized,
          switchOutCurve: Curves.easeInOutCubicEmphasized,
          child: switch (state.navItem) {
            HomepageNavigationItem.bookshelf =>
              const BookshelfFloatingActionButton(),
            _ => null,
          },
        );
      },
    );
  }
}
