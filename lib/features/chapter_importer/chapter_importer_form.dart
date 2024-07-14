import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/zip_encoding_dropdown_menu.dart';
import 'bloc/chapter_importer_bloc.dart';
import '../common_components/common_checkbox_with_label/common_checkbox_with_label.dart';
import 'widgets/chapter_importer_submit_button.dart';
import 'widgets/chapter_importer_file_picker.dart';

class ChapterImporterForm extends StatelessWidget {
  const ChapterImporterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ChapterImporterCubit cubit = BlocProvider.of<ChapterImporterCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Form(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0, bottom: 32.0),
            child: ChapterImporterFilePicker(),
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
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 32.0),
            child: CommonCheckboxWithLabel(
              text: appLocalizations.importOverwriteBookmark,
              onChanged: (value) => cubit.setState(isOverwriteBookmark: value == true),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: ChapterImporterSubmitButton(),
          ),
        ],
      ),
    );
  }
}
