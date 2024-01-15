import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookFormInputBookName extends StatelessWidget {
  const BookFormInputBookName({
    super.key,
    this.initialValue,
    this.isShowHelp = true,
    this.labelText,
    this.onChanged,
    this.onSave,
    this.readOnly = false,
    this.validator,
  });

  final bool isShowHelp;
  final bool readOnly;
  final String? initialValue;
  final String? labelText;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    TextEditingController? controller = initialValue != null ? TextEditingController(text: initialValue) : null;

    return TextFormField(
      controller: controller,
      onSaved: onSave,
      onChanged: onChanged,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.all(24.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: !isShowHelp ? null : Padding(
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
