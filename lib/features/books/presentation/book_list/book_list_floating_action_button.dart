import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../add_page/book_add_page.dart';

class BookListFloatingActionButton extends StatelessWidget {
  const BookListFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (_) => const BookAddPage()));
      },
      tooltip: appLocalizations.accessibilityAddBookButton,
      child: const Icon(Icons.add),
    );
  }
}
