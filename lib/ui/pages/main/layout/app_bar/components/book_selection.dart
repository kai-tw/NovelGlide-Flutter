import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/motion/route_slide_transition.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/main.dart';
import 'package:novelglide/ui/pages/main/bloc/library_bloc.dart';

class MainPageAppBarBookSelection extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBarBookSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBookListCubit, LibraryBookListState>(builder: (context, state) {
      bool isAllSelect = state.bookList.length == state.selectedBooks.length;
      return AppBar(
        leading: IconButton(
          icon: Icon(isAllSelect ? Icons.check_box_rounded : Icons.indeterminate_check_box_rounded, size: 20.0),
          onPressed: () {
            if (isAllSelect) {
              BlocProvider.of<LibraryBookListCubit>(context).clearSelect(state);
            } else {
              BlocProvider.of<LibraryBookListCubit>(context).allSelect(state);
            }
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            state.selectedBooks.length.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded, size: 20.0),
            onPressed: () {
              Navigator.of(context).push(_routeToEditPage(state.selectedBooks)).then((_) {
                BlocProvider.of<LibraryBookListCubit>(context).refresh();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_rounded, size: 20.0),
            onPressed: () {
              _showConfirmDialog(context).then((isDelete) {
                if (isDelete != null && isDelete) {
                  BlocProvider.of<LibraryBookListCubit>(context).deleteSelectBook(state);
                }
              });
            },
          ),
        ],
      );
    });
  }

  Future<T?> _showConfirmDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirm_title),
          content: Text(AppLocalizations.of(context)!.confirm_content_delete),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  AppLocalizations.of(context)!.delete,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(AppLocalizations.of(context)!.cancel)),
          ],
        );
      },
    );
  }

  Route _routeToEditPage(Set<String> selectedSet) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          BookFormPage(BookFormType.multiEdit, selectedBooks: selectedSet),
      transitionsBuilder: routeBottomSlideTransition,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
