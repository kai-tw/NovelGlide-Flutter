import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/add_book/bloc/form_bloc.dart';

class AddBookInputBookName extends StatelessWidget {
  const AddBookInputBookName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBookFormCubit, AddBookFormState>(
        builder: (context, state) {
          return TextFormField(
              onSaved: (String? value) {},
              onChanged: (value) => BlocProvider.of<AddBookFormCubit>(context)
                  .bookNameVerify(state, value),
              validator: (_) {
                switch (state.bookNameErrorCode) {
                  case AddBookFormBookNameErrorCode.nothing:
                    return null;
                  case AddBookFormBookNameErrorCode.blank:
                    return AppLocalizations.of(context)!.add_book_book_name_blank;
                  case AddBookFormBookNameErrorCode.invalid:
                    return AppLocalizations.of(context)!.add_book_book_name_invalid;
                  case AddBookFormBookNameErrorCode.exists:
                    return AppLocalizations.of(context)!.add_book_book_exists;
                }
              },
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.add_book_book_name,
                  labelStyle: const TextStyle(fontSize: 16),
                  contentPadding: const EdgeInsets.all(24.0),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))));
        });
  }
}