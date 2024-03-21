import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_book_name_help_dialog.dart';
import '../common_components/common_form_decoration.dart';
import 'bloc/edit_book_form_bloc.dart';

class EditBookNameInputField extends StatelessWidget {
  const EditBookNameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final EditBookFormCubit cubit = BlocProvider.of<EditBookFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<EditBookNameStateCode, String> nameStateStringMap = {
      EditBookNameStateCode.blank: appLocalizations.input_field_blank,
      EditBookNameStateCode.invalid: appLocalizations.input_field_invalid,
      EditBookNameStateCode.exists: appLocalizations.book_exists,
    };
    return TextFormField(
      decoration: CommonFormDecoration.inputDecoration(
        appLocalizations.book_name,
        suffixIcon: IconButton(
          onPressed: () => showDialog(context: context, builder: (_) => const CommonBookNameHelpDialog()),
          icon: const Icon(Icons.help_outline_rounded),
        ),
      ),
      initialValue: cubit.oldData.name,
      validator: (value) => nameStateStringMap[cubit.nameVerify(value)],
    );
  }
}
