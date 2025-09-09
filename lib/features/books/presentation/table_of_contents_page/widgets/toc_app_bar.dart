import 'package:flutter/material.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../collection/presentation/add_book_page/collection_add_book_scaffold.dart';
import '../../../domain/entities/book.dart';

class TocAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TocAppBar({super.key, required this.bookData});

  final Book bookData;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AppBar(
      title: Text(
        bookData.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    CollectionAddBookScaffold(dataSet: <Book>{bookData}),
              ),
            );
          },
          icon: const Icon(Icons.collections_bookmark_outlined),
          tooltip: appLocalizations.generalCollection(2),
        ),
      ],
    );
  }
}
