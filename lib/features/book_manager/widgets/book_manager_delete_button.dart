import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/book_manager_bloc.dart';

class BookManagerDeleteButton extends StatelessWidget {
  const BookManagerDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BookManagerCubit cubit = BlocProvider.of<BookManagerCubit>(context);
    return BlocBuilder<BookManagerCubit, BookManagerState>(
      buildWhen: (previous, current) => previous.selectedBooks != current.selectedBooks,
      builder: (BuildContext context, BookManagerState state) {
        return FloatingActionButton.extended(
          foregroundColor: Theme.of(context).colorScheme.onError,
          backgroundColor: Theme.of(context).colorScheme.error,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  icon: const Icon(Icons.delete_forever_rounded, size: 48.0),
                  title: Text(AppLocalizations.of(context)!.alertDialogDeleteBookTitle),
                  content: Text(AppLocalizations.of(context)!.alertDialogDeleteBookDescription),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        cubit.deleteSelectedBooks();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.delete_rounded),
          label: Text(AppLocalizations.of(context)!.bookManagerDeleteNumberOfSelectedBooks(state.selectedBooks.length)),
        );
      },
    );
  }
}
