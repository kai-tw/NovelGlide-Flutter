import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/book_importer_bloc.dart';
import '../common_components/common_checkbox_with_label/common_checkbox_with_label.dart';
import 'widgets/book_importer_submit_button.dart';
import 'widgets/book_importer_file_picker.dart';

class BookImporterForm extends StatelessWidget {
  const BookImporterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final BookImporterCubit cubit = BlocProvider.of<BookImporterCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Form(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: BookImporterFilePicker(),
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
            child: BookImporterSubmitButton(),
          ),
        ],
      ),
    );
  }
}
