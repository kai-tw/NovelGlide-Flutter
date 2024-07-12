import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../common_components/common_back_button.dart';
import 'bloc/chapter_importer_bloc.dart';
import 'chapter_importer_form.dart';

class ChapterImporterScaffold extends StatelessWidget {
  const ChapterImporterScaffold({super.key, required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.bookImporter),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocProvider(
            create: (context) => ChapterImporterCubit(bookData),
            child: const ChapterImporterForm(),
          ),
        ),
      ),
    );
  }
}
