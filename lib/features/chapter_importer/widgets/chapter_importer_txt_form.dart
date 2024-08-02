import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../common_components/common_checkbox_with_label/common_checkbox_with_label.dart';
import '../../common_components/common_file_picker/common_file_picker_type.dart';
import '../bloc/chapter_importer_bloc.dart';
import 'chapter_importer_file_picker.dart';
import 'chapter_importer_submit_button.dart';

class ChapterImporterTxtForm extends StatelessWidget {
  final BookData bookData;

  const ChapterImporterTxtForm({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final ChapterImporterCubit cubit = ChapterImporterCubit(bookData);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Form(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 360),
            child: BlocProvider(
              create: (_) => cubit,
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
            ),
          ),
        ),
      ),
    );
  }
}