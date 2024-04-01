import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_file_picker/common_file_picker.dart';
import '../common_components/common_file_picker/common_file_picker_type.dart';
import '../common_components/common_form_help_button.dart';
import 'bloc/add_chapter_form_bloc.dart';

class AddChapterFilePicker extends StatelessWidget {
  const AddChapterFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final AddChapterFormCubit cubit = BlocProvider.of<AddChapterFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    const List<String> allowedExtensions = ["txt"];

    return CommonFilePicker(
      labelText: appLocalizations.titleSelectFile,
      type: CommonFilePickerType.custom,
      allowedExtensions: allowedExtensions,
      onSaved: (file) => cubit.file = file,
      suffixIcon: CommonFormHelpButton(
        title: appLocalizations.ruleDialogFileAcceptedTitle,
        content: appLocalizations.ruleDialogFileAccepted + allowedExtensions.join(", "),
      ),
    );
  }
}
