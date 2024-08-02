import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../book_importer/book_importer_form.dart';
import '../common_components/common_back_button.dart';
import 'add_book_form.dart';

class AddBookScaffold extends StatelessWidget {
  const AddBookScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(AppLocalizations.of(context)!.titleAddBook),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.titleAddBook),
              Tab(text: AppLocalizations.of(context)!.importFromZip),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              AddBookForm(),
              BookImporterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
