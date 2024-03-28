import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_form_decoration.dart';
import '../common_components/common_form_help_button.dart';
import 'bloc/add_chapter_form_bloc.dart';

class AddChapterNumberInputField extends StatelessWidget {
  const AddChapterNumberInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddChapterFormCubit cubit = BlocProvider.of<AddChapterFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<AddChapterNumberStateCode, String> nameStateStringMap = {
      AddChapterNumberStateCode.blank: appLocalizations.fieldBlank,
      AddChapterNumberStateCode.invalid: appLocalizations.fieldInvalid,
      AddChapterNumberStateCode.exists: appLocalizations.fieldItemExists,
    };
    return TextFormField(
      decoration: CommonFormDecoration.inputDecoration(
        appLocalizations.fieldChapterNumber,
        suffixIcon: CommonFormHelpButton(
          title: appLocalizations.ruleDialogChapterNumberTitle,
          content: appLocalizations.ruleDialogChapterNumberContent,
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) => nameStateStringMap[cubit.numberVerify(value)],
      onSaved: (value) => cubit.chapterNumber = int.parse(value!),
    );
  }
}
