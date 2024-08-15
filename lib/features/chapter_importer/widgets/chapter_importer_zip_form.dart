import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/book_data.dart';
import '../../common_components/common_checkbox_with_label/common_checkbox_with_label.dart';
import '../../common_components/common_file_picker/common_file_picker_type.dart';
import '../../common_components/zip_encoding_dropdown_menu.dart';
import '../bloc/chapter_importer_bloc.dart';
import 'chapter_importer_submit_button.dart';
import 'chapter_importer_file_picker.dart';

class ChapterImporterZipForm extends StatelessWidget {
  final BookData bookData;

  const ChapterImporterZipForm({super.key, required this.bookData});

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
                      type: CommonFilePickerType.zip,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: ZipEncodingDropdownMenu(
                      onSelected: (zipEncoding) => cubit.setZipEncoding(zipEncoding),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CommonCheckboxWithLabel(
                      text: appLocalizations.importOverwriteChapter,
                      onChanged: (value) => cubit.setState(isOverwriteChapter: value == true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CommonCheckboxWithLabel(
                      text: appLocalizations.importOverwriteCover,
                      onChanged: (value) => cubit.setState(isOverwriteCover: value == true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CommonCheckboxWithLabel(
                      text: appLocalizations.importOverwriteBookmark,
                      onChanged: (value) => cubit.setState(isOverwriteBookmark: value == true),
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
