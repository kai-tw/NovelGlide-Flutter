import 'package:flutter/material.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../domain/entities/book_pick_file_data.dart';

class BookAddFileTile extends StatelessWidget {
  const BookAddFileTile({
    super.key,
    required this.data,
    required this.onDeletePressed,
  });

  final BookPickFileData data;
  final void Function() onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    String subtitle = data.fileSize;

    // Check if the file is duplicated
    if (data.existsInLibrary) {
      subtitle = appLocalizations.bookExists;
    }

    // Check if the file is invalid
    if (!data.isTypeValid) {
      subtitle = appLocalizations.fileTypeForbidden;
    }

    return ListTile(
      leading: Icon(
        data.isValid ? Icons.book_rounded : Icons.error_rounded,
        color: data.isValid ? null : Theme.of(context).colorScheme.error,
      ),
      title: Text(
        data.baseName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: data.isValid ? null : Theme.of(context).colorScheme.error,
        ),
      ),
      trailing: IconButton(
        onPressed: onDeletePressed,
        icon: const Icon(Icons.delete),
        tooltip: appLocalizations.generalDelete,
      ),
    );
  }
}
