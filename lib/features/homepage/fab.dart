import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/features/add_book/scaffold.dart';

import 'bloc/navigation_bloc.dart';

class HomepageFab extends StatelessWidget {
  const HomepageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: state.showFab ? Offset.zero : const Offset(2, 0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: state.showFab ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  scrollControlDisabledMaxHeightRatio: 1.0,
                  showDragHandle: true,
                  builder: (BuildContext context) {
                    return AddBookPage();
                  },
                );
              },
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        );
      },
    );
  }
}
