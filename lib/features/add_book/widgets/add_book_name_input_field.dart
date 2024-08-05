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

    return TextFormField(
      decoration: InputDecoration(
        labelText: appLocalizations.fieldBookName,
        helperText: '${appLocalizations.fieldBookNameHelperText}${VerifyUtility.folderNameDenyPattern}',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.deny(VerifyUtility.folderNameDenyRegex),
      ],
      validator: (value) {
        switch (cubit.nameVerify(value)) {
          case AddBookFormNameStateCode.valid:
            return null;
          case AddBookFormNameStateCode.blank:
            return appLocalizations.fieldBlank;
          case AddBookFormNameStateCode.invalid:
            return appLocalizations.fieldInvalid;
          case AddBookFormNameStateCode.exists:
            return appLocalizations.fieldItemExists;
        }
      },
      onSaved: (value) => cubit.data.name = value!,
    );
  }
}
