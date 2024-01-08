import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';

class BookFormInputBookName extends StatelessWidget {
  const BookFormInputBookName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookFormCubit, BookFormState>(
      builder: (context, state) {
        return TextFormField(
          onSaved: (String? value) => BlocProvider.of<BookFormCubit>(context).saveData(bookName: value),
          onChanged: (String? value) => BlocProvider.of<BookFormCubit>(context).bookNameVerify(state, value),
          validator: (_) {
            switch (state.nameErrorCode) {
              case BookFormNameErrorCode.nothing:
                return null;
              case BookFormNameErrorCode.blank:
                return AppLocalizations.of(context)!.book_name_blank;
              case BookFormNameErrorCode.invalid:
                return AppLocalizations.of(context)!.book_name_invalid;
              case BookFormNameErrorCode.exists:
                return AppLocalizations.of(context)!.book_exists;
            }
          },
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.book_name,
            labelStyle: const TextStyle(fontSize: 16),
            contentPadding: const EdgeInsets.all(24.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () => _showHelpDialog(context),
                icon: const Icon(Icons.help_outline_rounded),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<T?> _showHelpDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.book_name_rule_title),
          content: Text(
              '${AppLocalizations.of(context)!.book_name_rule_content}_ -.,&()@#\$%^+=\[{\]};\'~`<>?| 和空白'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        );
      },
    );
  }
}
