import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_file_picker/common_file_picker.dart';
import '../common_components/common_file_picker/common_file_picker_type.dart';

class AddChapterFilePicker extends StatelessWidget {
  const AddChapterFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonFilePicker(
      labelText: AppLocalizations.of(context)!.title_select_a_file,
      type: CommonFilePickerType.custom,
      allowedExtensions: const ["txt"],
    );
  }
}