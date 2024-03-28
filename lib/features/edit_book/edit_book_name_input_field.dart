import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/verify_utility.dart';
import '../common_components/common_form_decoration.dart';
import '../common_components/common_form_help_button.dart';
import 'bloc/edit_book_form_bloc.dart';

class EditBookNameInputField extends StatelessWidget {
  const EditBookNameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final EditBookFormCubit cubit = BlocProvider.of<EditBookFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<EditBookNameStateCode, String> nameStateStringMap = {
      EditBookNameStateCode.blank: appLocalizations.fieldBlank,
      EditBookNameStateCode.invalid: appLocalizations.fieldInvalid,
      EditBookNameStateCode.exists: appLocalizations.fieldItemExists,
    };
    return TextFormField(
      decoration: CommonFormDecoration.inputDecoration(
        appLocalizations.bookName,
        suffixIcon: CommonFormHelpButton(
          title: appLocalizations.ruleDialogBookNameTitle,
          content: '${appLocalizations.ruleDialogBookNameContent}${VerifyUtility.folderNamePattern}',
        ),
      ),
      initialValue: cubit.oldData.name,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.deny(VerifyUtility.folderNameRegex),
      ],
      validator: (value) => nameStateStringMap[cubit.nameVerify(value)],
    );
  }
}
