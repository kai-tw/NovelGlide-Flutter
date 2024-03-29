import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_file_picker/common_file_picker.dart';
import '../common_components/common_file_picker/common_file_picker_type.dart';
import 'bloc/add_chapter_form_bloc.dart';

class AddChapterFilePicker extends StatelessWidget {
  const AddChapterFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final AddChapterFormCubit cubit = BlocProvider.of<AddChapterFormCubit>(context);
    return CommonFilePicker(
      labelText: AppLocalizations.of(context)!.titleSelectFile,
      type: CommonFilePickerType.custom,
      allowedExtensions: const ["txt"],
      onSaved: (file) => cubit.file = file,
    );
  }
}