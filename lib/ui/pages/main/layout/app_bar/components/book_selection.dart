import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';

class MainPageAppBarBookSelection extends StatelessWidget implements PreferredSizeWidget{
  const MainPageAppBarBookSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBookListCubit, LibraryBookListState>(builder: (context, state) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            BlocProvider.of<LibraryBookListCubit>(context).clearSelect(state);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            state.selectedBook.length.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
