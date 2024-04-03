import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'add_chapter_form.dart';

class AddChapterScaffold extends StatelessWidget {
  const AddChapterScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.titleAddChapter),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: AddChapterForm(),
      ),
    );
  }
}
