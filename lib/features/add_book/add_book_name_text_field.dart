import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_book_name_help_dialog.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookNameTextField extends StatelessWidget {
  const AddBookNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookFormCubit cubit = BlocProvider.of<AddBookFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<AddBookFormNameStateCode, String> nameStateStringMap = {
      AddBookFormNameStateCode.blank: appLocalizations.input_field_blank,
      AddBookFormNameStateCode.invalid: appLocalizations.input_field_invalid,
      AddBookFormNameStateCode.exists: appLocalizations.book_exists,
    };

    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.book_name,
        labelStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.all(24.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () => showDialog(context: context, builder: (_) => const CommonBookNameHelpDialog()),
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ),
      ),
      validator: (value) => nameStateStringMap[cubit.nameVerify(value)],
    );
  }
}