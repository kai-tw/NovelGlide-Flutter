import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../common_components/common_back_button.dart';
import 'bloc/chapter_importer_bloc.dart';
import 'widgets/chapter_importer_zip_form.dart';
import 'widgets/chapter_importer_scroll_view.dart';
import 'widgets/chapter_importer_txt_form.dart';

class ChapterImporterScaffold extends StatelessWidget {
  const ChapterImporterScaffold({super.key, required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ChapterImporterCubit(bookData),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: const CommonBackButton(),
            title: Text(appLocalizations.chapterImporter),
            bottom: TabBar(
              tabs: [
                Tab(text: appLocalizations.importFromZip),
                Tab(text: appLocalizations.importFromTxt),
              ],
            ),
          ),
          body: const SafeArea(
            child: TabBarView(
              children: [
                ChapterImporterScrollView(
                  child: ChapterImporterZipForm(),
                ),
                ChapterImporterScrollView(
                  child: ChapterImporterTxtForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
