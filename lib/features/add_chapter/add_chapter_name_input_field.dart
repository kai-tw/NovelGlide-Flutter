import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_form_decoration.dart';
import 'bloc/add_chapter_form_bloc.dart';

class AddChapterNameInputField extends StatelessWidget {
  const AddChapterNameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddChapterFormCubit cubit = BlocProvider.of<AddChapterFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<AddChapterNameStateCode, String> nameStateStringMap = {
      AddChapterNameStateCode.blank: appLocalizations.fieldBlank,
      AddChapterNameStateCode.invalid: appLocalizations.fieldInvalid,
    };
    return TextFormField(
      decoration: CommonFormDecoration.inputDecoration(appLocalizations.fieldChapterName),
      validator: (value) => nameStateStringMap[cubit.nameVerify(value)],
    );
  }
}
