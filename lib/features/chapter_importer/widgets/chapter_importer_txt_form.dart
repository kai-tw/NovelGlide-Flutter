import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_checkbox_with_label/common_checkbox_with_label.dart';
import '../../common_components/common_file_picker/common_file_picker_type.dart';
import '../bloc/chapter_importer_bloc.dart';
import 'chapter_importer_file_picker.dart';
import 'chapter_importer_submit_button.dart';

class ChapterImporterTxtForm extends StatelessWidget {
  const ChapterImporterTxtForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ChapterImporterCubit cubit = BlocProvider.of<ChapterImporterCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Form(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0, bottom: 32.0),
            child: ChapterImporterFilePicker(
              type: CommonFilePickerType.txt,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CommonCheckboxWithLabel(
              text: appLocalizations.importOverwriteChapter,
              onChanged: (value) => cubit.setState(isOverwriteChapter: value == true),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ChapterImporterSubmitButton(),
            ),
          ),
        ],
      ),
    );
  }
}