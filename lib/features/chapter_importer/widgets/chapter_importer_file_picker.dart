import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_file_picker/common_file_picker.dart';
import '../../common_components/common_file_picker/common_file_picker_type.dart';
import '../bloc/chapter_importer_bloc.dart';

class ChapterImporterFilePicker extends StatelessWidget {
  const ChapterImporterFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final String extensionText = CommonFilePickerTypeMap.extension[CommonFilePickerType.archive]!.join();
    return CommonFilePicker(
      inputDecoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.selectAFile,
        helperText: AppLocalizations.of(context)!.fileTypeHelperText + extensionText,
      ),
      type: CommonFilePickerType.archive,
      onSaved: (file) => BlocProvider.of<ChapterImporterCubit>(context).importFile = file,
    );
  }
}