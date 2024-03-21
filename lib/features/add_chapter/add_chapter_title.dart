import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddChapterTitle extends StatelessWidget {
  const AddChapterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.title_add_chapter,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20),
    );
  }

}