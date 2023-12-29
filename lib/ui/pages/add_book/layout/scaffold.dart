import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _bodyWidget());
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.add_book_title)));
  }

  Widget _bodyWidget() {
    return Container();
  }
}
