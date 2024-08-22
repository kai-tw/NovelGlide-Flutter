import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../add_book/add_book_scaffold.dart';
import '../bloc/bookshelf_bloc.dart';

class BookshelfAddBookButton extends StatelessWidget {
  const BookshelfAddBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddBookScaffold())).then((_) {
          if (context.mounted) {
            BlocProvider.of<BookshelfCubit>(context).refresh();
          }
        });
      },
      child: Icon(
        Icons.add,
        semanticLabel: AppLocalizations.of(context)!.accessibilityAddBookButton,
      ),
    );
  }
}
