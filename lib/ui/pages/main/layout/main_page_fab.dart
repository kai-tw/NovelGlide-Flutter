import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/add_book/layout/add_book_page_scaffold.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation.dart';

class MainPageFab extends StatelessWidget {
  const MainPageFab({super.key});

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
                  onPressed: () => onPressed(context),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.add,
                      color: Theme.of(context).colorScheme.onPrimary))));
    });
  }

  void onPressed(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddBookPage()))
        .then((_) {
      BlocProvider.of<NavigationCubit>(context).setItem(NavigationItem.library);
    });
  }
}
