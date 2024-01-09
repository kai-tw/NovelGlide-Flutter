import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookFormInputBookName extends StatelessWidget {
  const BookFormInputBookName({super.key, this.onSave, this.onChanged, this.validator, this.labelText});

  final void Function(String?)? onSave;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSave,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.all(24.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () => _showHelpDialog(context),
            icon: const Icon(Icons.help_outline_rounded),
          ),
        ),
      ),
    );
  }

  Future<T?> _showHelpDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.book_name_rule_title),
          content: Text('${AppLocalizations.of(context)!.book_name_rule_content}_ -.,&()@#\$%^+=[{]};\'~`<>?| 和空白'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        );
      },
    );
  }
}
