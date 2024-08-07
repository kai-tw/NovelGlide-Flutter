import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/bookshelf_bloc.dart';

class BookshelfDeleteButton extends StatelessWidget {
  const BookshelfDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: const Icon(Icons.delete_forever_rounded, size: 48.0),
              title: Text(appLocalizations.alertDialogDeleteBookTitle),
              content: Text(appLocalizations.alertDialogDeleteBookDescription),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(appLocalizations.generalCancel),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cubit.deleteSelectedBooks();
                  },
                  child: Text(
                    appLocalizations.generalYes,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Theme.of(context).colorScheme.error,
        fixedSize: const Size(double.infinity, 56.0),
        minimumSize: const Size(double.infinity, 56.0),
      ),
      icon: const Icon(Icons.delete_rounded),
      label: BlocBuilder<BookshelfCubit, BookshelfState>(
        buildWhen: (previous, current) => previous.selectedBooks != current.selectedBooks,
        builder: (context, state) {
          return Text(appLocalizations.bookshelfDeleteNumberOfSelectedBooks(state.selectedBooks.length));
        },
      ),
    );
  }
}
