import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';
import 'package:novelglide/ui/pages/main/layout/app_bar/components/book_selection.dart';
import 'package:novelglide/ui/pages/main/layout/app_bar/components/default.dart';

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBookListCubit, LibraryBookListState>(builder: (context, state) {
      if (state.isSelecting) {
        return const MainPageAppBarBookSelection();
      }
      return const MainPageAppBarDefault();
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
