import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../add_page/book_add_page.dart';

class BookListFloatingActionButton extends StatelessWidget {
  const BookListFloatingActionButton({
    super.key,
    this.enabled = true,
  });

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return FloatingActionButton(
      onPressed: enabled
          ? () {
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const BookAddPage()));
            }
          : null,
      tooltip: appLocalizations.accessibilityAddBookButton,
      child: const Icon(Icons.add),
    );
  }
}
