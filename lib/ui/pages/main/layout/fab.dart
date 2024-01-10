import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/motion/route_slide_transition.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/main.dart';
import 'package:novelglide/ui/pages/main/bloc/library_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation_bloc.dart';

class MainPageFab extends StatelessWidget {
  const MainPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(builder: (context, state) {
      return AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: state.showFab ? Offset.zero : const Offset(2, 0),
          child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: state.showFab ? 1 : 0,
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(_routeToAddBookPage()).then((_) {
                      BlocProvider.of<LibraryBookListCubit>(context).refresh();
                    });
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary))));
    });
  }

  Route _routeToAddBookPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const BookFormPage(BookFormType.add),
      transitionsBuilder: routeBottomSlideTransition,
    );
  }
}
