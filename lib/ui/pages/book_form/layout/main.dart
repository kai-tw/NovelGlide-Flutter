import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/form_main.dart';

class BookFormPage extends StatelessWidget {
  const BookFormPage(this.formType, {super.key, this.oldBookName, this.selectedBooks});

  final BookFormType formType;
  final String? oldBookName;
  final Set<String>? selectedBooks;

  @override
  Widget build(BuildContext context) {
    String pageTitle = '';
    switch (formType) {
      case BookFormType.add:
        pageTitle = AppLocalizations.of(context)!.title_add_book;
        break;
      case BookFormType.edit:
        pageTitle = AppLocalizations.of(context)!.title_edit_book;
        break;
      case BookFormType.multiEdit:
        pageTitle = AppLocalizations.of(context)!.title_multiEdit_book;
        break;
    }

    // To prevent the wrong snack bar showing.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    return BlocProvider(
      create: (_) => BookFormCubit(formType),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(pageTitle),
          ),
        ),
        body: BookFormWidget(oldName: oldBookName, selectedBooks: selectedBooks),
      ),
    );
  }
}
