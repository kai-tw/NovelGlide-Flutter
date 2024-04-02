import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'edit_book_form.dart';

class EditBookScaffold extends StatelessWidget {
  const EditBookScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(AppLocalizations.of(context)!.titleEditBook),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: EditBookForm(),
      ),
    );
  }
}
