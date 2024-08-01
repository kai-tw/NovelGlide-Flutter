import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/window_class.dart';
import '../common_components/common_back_button.dart';
import 'bloc/add_chapter_form_bloc.dart';
import 'widgets/add_chapter_file_picker.dart';
import 'widgets/add_chapter_number_input_field.dart';
import 'widgets/add_chapter_submit_button.dart';
import 'widgets/add_chapter_title_input_field.dart';

class AddChapterScaffold extends StatelessWidget {
  const AddChapterScaffold({super.key, required this.bookName});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.titleAddChapter),
      ),
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                constraints: const BoxConstraints(maxWidth: 360),
                child: BlocProvider(
                  create: (_) => AddChapterFormCubit(bookName),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: AddChapterNumberInputField(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: AddChapterTitleInputField(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: AddChapterFilePicker(),
                      ),
                      AddChapterSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
