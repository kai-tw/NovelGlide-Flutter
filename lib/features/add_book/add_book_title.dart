import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBookTitle extends StatelessWidget {
  const AddBookTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.titleAddBook,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20),
    );
  }

}