import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../common_components/common_back_button.dart';
import 'widgets/chapter_importer_zip_form.dart';
import 'widgets/chapter_importer_txt_form.dart';

class ChapterImporterScaffold extends StatelessWidget {
  const ChapterImporterScaffold({super.key, required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(appLocalizations.importChapter),
          bottom: TabBar(
            tabs: [
              Tab(text: appLocalizations.importFromZip),
              Tab(text: appLocalizations.importFromTxt),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              ChapterImporterZipForm(bookData: bookData),
              ChapterImporterTxtForm(bookData: bookData),
            ],
          ),
        ),
      ),
    );
  }
}
