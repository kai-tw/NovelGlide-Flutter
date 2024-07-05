import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'add_chapter_form.dart';
import 'bloc/add_chapter_form_bloc.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocProvider(
          create: (_) => AddChapterFormCubit(bookName),
          child: const AddChapterForm(),
        ),
      ),
    );
  }
}
