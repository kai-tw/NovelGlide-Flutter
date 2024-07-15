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
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    final Widget bodyWidget;

    switch (windowClass) {
      case WindowClass.compact:
        bodyWidget = const AddChapterScaffoldCompactView();
        break;
      default:
        bodyWidget = const AddChapterScaffoldMediumView();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.titleAddChapter),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocProvider(
              create: (_) => AddChapterFormCubit(bookName),
              child: bodyWidget,
            ),
          ),
        ),
      ),
    );
  }
}

class AddChapterScaffoldCompactView extends StatelessWidget {
  const AddChapterScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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
    );
  }
}

class AddChapterScaffoldMediumView extends StatelessWidget {
  const AddChapterScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 16.0),
                        width: constraints.maxWidth / 2,
                        child: const AddChapterNumberInputField(),
                      ),
                      const Expanded(
                        child: AddChapterFilePicker(),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 32.0),
              child: AddChapterTitleInputField(),
            ),
            const AddChapterSubmitButton(),
          ],
        ),
      ),
    );
  }
}
