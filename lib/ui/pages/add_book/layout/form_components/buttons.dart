import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBookSubmitButton extends StatelessWidget {
  const AddBookSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
            onPressed: () {
              if (Form.of(context).validate()) {
                Form.of(context).save();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.add_book_form_processing)),
                );
              }
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: Text(AppLocalizations.of(context)!.form_submit,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary))));
  }
}