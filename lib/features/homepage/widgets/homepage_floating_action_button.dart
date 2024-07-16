import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bookshelf/widgets/bookshelf_add_book_button.dart';
import '../bloc/navigation_bloc.dart';

class HomepageFloatingActionButton extends StatelessWidget {
  const HomepageFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (NavigationState previous, NavigationState current) => previous.navItem != current.navItem,
      builder: (BuildContext context, NavigationState state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized)).animate(animation),
              child: child,
            );
          },
          child: state.navItem == NavigationItem.bookshelf ? const BookshelfAddBookButton() : null,
        );
      },
    );
  }
}