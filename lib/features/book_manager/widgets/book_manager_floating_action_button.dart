import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_manager_bloc.dart';
import 'book_manager_delete_button.dart';

class BookManagerFloatingActionButton extends StatelessWidget {
  const BookManagerFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookManagerCubit, BookManagerState>(
      buildWhen: (previous, current) => previous.selectedBooks != current.selectedBooks,
      builder: (BuildContext context, BookManagerState state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized)).animate(animation),
              child: child,
            );
          },
          child: state.selectedBooks.isEmpty ? null : const BookManagerDeleteButton(),
        );
      },
    );
  }
}