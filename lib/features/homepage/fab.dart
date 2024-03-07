import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_book/add_book_callee_add_button.dart';
import '../bookshelf/bloc/bookshelf_bloc.dart';
import 'bloc/navigation_bloc.dart';

class HomepageFab extends StatelessWidget {
  const HomepageFab({super.key});

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: state.showFab ? Offset.zero : const Offset(2, 0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: state.showFab ? 1 : 0,
            child: AddBookCalleeAddButton(
              callback: (_) => cubit.refresh(),
            ),
          ),
        );
      },
    );
  }
}
