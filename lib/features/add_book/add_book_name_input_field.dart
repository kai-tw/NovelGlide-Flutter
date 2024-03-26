import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/verify_utility.dart';
import '../common_components/common_form_decoration.dart';
import '../common_components/common_form_help_button.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookNameInputField extends StatelessWidget {
  const AddBookNameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookFormCubit cubit = BlocProvider.of<AddBookFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<AddBookFormNameStateCode, String> nameStateStringMap = {
      AddBookFormNameStateCode.blank: appLocalizations.fieldBlank,
      AddBookFormNameStateCode.invalid: appLocalizations.fieldInvalid,
      AddBookFormNameStateCode.exists: appLocalizations.fieldBookExists,
    };

    return TextFormField(
      decoration: CommonFormDecoration.inputDecoration(
        appLocalizations.bookName,
        suffixIcon: CommonFormHelpButton(
          title: appLocalizations.ruleDialogBookNameTitle,
          content: '${appLocalizations.ruleDialogBookNameContent}${VerifyUtility.folderNamePattern}',
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.deny(VerifyUtility.folderNameRegex),
      ],
      validator: (value) => nameStateStringMap[cubit.nameVerify(value)],
    );
  }
}
