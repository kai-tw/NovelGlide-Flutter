import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
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
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.add_book_book_name,
                        labelStyle: const TextStyle(fontSize: 16),
                        contentPadding: const EdgeInsets.all(24.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)))),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                        onPressed: _submitButtonPressed,
                        style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary),
                        child: Text(AppLocalizations.of(context)!.form_submit,
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onPrimary))))
              ],
            )));
  }

  void _submitButtonPressed() {}
}
