import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'book_importer_form.dart';

class BookImporterScaffold extends StatelessWidget {
  const BookImporterScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.importBook),
      ),
      body: const SafeArea(
        child: BookImporterForm(),
      ),
    );
  }
}