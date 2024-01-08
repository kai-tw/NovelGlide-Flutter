import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/edit_book/layout/form.dart';

class EditBookPage extends StatelessWidget {
  const EditBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(AppLocalizations.of(context)!.add_book_title),
        ),
      ),
      body: EditBookFormWidget(),
    );
  }
}
