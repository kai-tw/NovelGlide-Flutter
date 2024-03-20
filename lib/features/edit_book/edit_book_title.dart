import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditBookTitle extends StatelessWidget {
  const EditBookTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.title_edit_book,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20),
    );
  }
}