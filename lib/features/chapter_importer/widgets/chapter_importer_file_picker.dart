import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_file_picker/common_file_picker.dart';
import '../../common_components/common_file_picker/common_file_picker_type.dart';
import '../bloc/chapter_importer_bloc.dart';

class ChapterImporterFilePicker extends StatelessWidget {
  final CommonFilePickerType type;

  const ChapterImporterFilePicker({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final String extensionText = type.extensions!.join();
    return CommonFilePicker(
      inputDecoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.fieldSelectAFile,
        helperText: AppLocalizations.of(context)!.fileTypeHelperText + extensionText,
      ),
      type: type,
      onSaved: (file) => BlocProvider.of<ChapterImporterCubit>(context).setImportFile(file),
    );
  }
}