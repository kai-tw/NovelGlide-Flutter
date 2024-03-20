import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/add_book_form_bloc.dart';

class AddBookNameTextField extends StatelessWidget {
  const AddBookNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookFormCubit cubit = BlocProvider.of<AddBookFormCubit>(context);
    final Map<AddBookFormNameStateCode, String> nameStateStringMap = {
      AddBookFormNameStateCode.blank: AppLocalizations.of(context)!.input_field_blank,
      AddBookFormNameStateCode.invalid: AppLocalizations.of(context)!.input_field_invalid,
      AddBookFormNameStateCode.exists: AppLocalizations.of(context)!.book_exists,
    };

    return TextFormField(
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
            onPressed: () => showDialog(context: context, builder: _helpDialog),
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ),
      ),
      validator: (value) => nameStateStringMap[cubit.nameVerify(value)],
    );
  }

  AlertDialog _helpDialog(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.book_name_rule_title),
      content: Text('${AppLocalizations.of(context)!.book_name_rule_content}_ -.,&()@#\$%^+=[{]};\'~`<>?|'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.close),
        ),
      ],
    );
  }
}