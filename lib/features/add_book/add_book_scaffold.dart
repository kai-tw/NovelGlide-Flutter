import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'add_book_form.dart';

class AddBookScaffold extends StatelessWidget {
  const AddBookScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(AppLocalizations.of(context)!.titleAddBook),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: AddBookForm(),
      ),
    );
  }
}
