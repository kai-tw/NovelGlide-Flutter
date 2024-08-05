import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../chapter_importer/widgets/chapter_importer_txt_form.dart';
import '../chapter_importer/widgets/chapter_importer_zip_form.dart';
import '../common_components/common_back_button.dart';
import 'add_chapter_form.dart';

class AddChapterScaffold extends StatelessWidget {
  final String bookName;

  const AddChapterScaffold({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.titleAddChapter),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: [
              Tab(text: appLocalizations.titleAddChapter),
              Tab(text: appLocalizations.importFromZip),
              Tab(text: appLocalizations.importFromTxt),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              AddChapterForm(bookName: bookName),
              ChapterImporterZipForm(bookData: BookData.fromName(bookName)),
              ChapterImporterTxtForm(bookData: BookData.fromName(bookName)),
            ],
          ),
        ),
      ),
    );
  }
}
