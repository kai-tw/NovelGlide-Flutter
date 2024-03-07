import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBookSliverTitle extends StatelessWidget {
  const AddBookSliverTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        AppLocalizations.of(context)!.title_add_book,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

}