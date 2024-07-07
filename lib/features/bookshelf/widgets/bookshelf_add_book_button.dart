import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../add_book/add_book_scaffold.dart';
import '../bloc/bookshelf_bloc.dart';

class BookshelfAddBookButton extends StatelessWidget {
  const BookshelfAddBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Semantics(
      label: appLocalizations.accessibilityAddBookButton,
      button: true,
      enabled: true,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) => const AddBookScaffold()))
              .then((isSuccess) {
            final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
            final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
            if (isSuccess == true) {
              cubit.refresh();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(appLocalizations.addWhatSuccessfully(appLocalizations.book)),
              ));
            } else if (isSuccess == false) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(appLocalizations.addWhatFailed(appLocalizations.book)),
              ));
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}