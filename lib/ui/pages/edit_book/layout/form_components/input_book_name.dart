import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/edit_book/bloc/form_bloc.dart';

class EditBookInputBookName extends StatelessWidget {
  const EditBookInputBookName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBookFormCubit, EditBookFormState>(
      builder: (context, state) {
        return TextFormField(
          onSaved: (String? value) => BlocProvider.of<EditBookFormCubit>(context).saveData(bookName: value),
          onChanged: (String? value) => BlocProvider.of<EditBookFormCubit>(context).bookNameVerify(state, value),
          validator: (_) {
            switch (state.bookNameErrorCode) {
              case EditBookFormBookNameErrorCode.nothing:
                return null;
              case EditBookFormBookNameErrorCode.blank:
                return AppLocalizations.of(context)!.book_name_blank;
              case EditBookFormBookNameErrorCode.invalid:
                return AppLocalizations.of(context)!.book_name_invalid;
              case EditBookFormBookNameErrorCode.exists:
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
