import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/form_bloc.dart';

class EditBookSliverNameTextField extends StatelessWidget {
  const EditBookSliverNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBookFormCubit, EditBookFormState>(
      builder: (BuildContext context, EditBookFormState state) {
        return SliverToBoxAdapter(
          child: TextFormField(
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
            initialValue: state.formValue.name,
            onChanged: (String value) {
              BlocProvider.of<EditBookFormCubit>(context).nameVerify(value);
            },
            validator: (_) => _nameStateCodeToMessage(context, state.nameStateCode),
          ),
        );
      },
    );
  }

  AlertDialog _helpDialog(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.book_name_rule_title),
      content: Text('${AppLocalizations.of(context)!.book_name_rule_content}_ -.,&()@#\$%^+=[{]};\'~`<>?| 和空白'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.close),
        ),
      ],
    );
  }

  String? _nameStateCodeToMessage(BuildContext context, EditBookNameStateCode code) {
    switch (code) {
      case EditBookNameStateCode.blank:
        return AppLocalizations.of(context)!.input_field_blank;
      case EditBookNameStateCode.invalid:
        return AppLocalizations.of(context)!.input_field_invalid;
      case EditBookNameStateCode.exists:
        return AppLocalizations.of(context)!.book_exists;
      case EditBookNameStateCode.valid:
      case EditBookNameStateCode.same:
        return null;
    }
  }
}
