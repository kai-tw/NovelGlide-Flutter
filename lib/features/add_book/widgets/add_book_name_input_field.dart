import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../toolbox/verify_utility.dart';
import '../bloc/add_book_form_bloc.dart';

class AddBookNameInputField extends StatelessWidget {
  const AddBookNameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookFormCubit cubit = BlocProvider.of<AddBookFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<AddBookFormNameStateCode, String> nameStateStringMap = {
      AddBookFormNameStateCode.blank: appLocalizations.fieldBlank,
      AddBookFormNameStateCode.invalid: appLocalizations.fieldInvalid,
      AddBookFormNameStateCode.exists: appLocalizations.fieldItemExists,
    };

    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.bookName,
        helperText: '${appLocalizations.bookNameHelperText}${VerifyUtility.folderNameDenyPattern}',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.deny(VerifyUtility.folderNameDenyRegex),
      ],
      validator: (value) => nameStateStringMap[cubit.nameVerify(value)],
      onSaved: (value) => cubit.data.name = value!,
    );
  }
}