import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/library_bloc.dart';
import 'package:novelglide/ui/pages/main/layout/app_bar/components/book_selection.dart';
import 'package:novelglide/ui/pages/main/layout/app_bar/components/default.dart';

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBookListCubit, LibraryBookListState>(builder: (context, state) {
      Widget child;
      switch (state.code) {
        case LibraryBookListStateCode.selecting:
          child = const MainPageAppBarBookSelection();
          break;
        default:
          child = const MainPageAppBarDefault();
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
