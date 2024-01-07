import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';

class MainPageAppBarBookSelection extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBarBookSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBookListCubit, LibraryBookListState>(builder: (context, state) {
      bool isAllSelect = state.bookList.length == state.selectedBook.length;
      return AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          onPressed: () {
            BlocProvider.of<LibraryBookListCubit>(context).clearSelect(state);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  isAllSelect ? Icons.check_box_rounded : Icons.indeterminate_check_box_rounded,
                  size: 20,
                ),
                onPressed: () {
                  if (isAllSelect) {
                    debugPrint('Not select all');
                    BlocProvider.of<LibraryBookListCubit>(context).clearSelect(state);
                  } else {
                    BlocProvider.of<LibraryBookListCubit>(context).allSelect(state);
                    debugPrint('Select all');
                  }
                },
              ),
              Text(
                state.selectedBook.length.toString(),
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_rounded),
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
