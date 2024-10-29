import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../common_components/common_back_button.dart';
import '../toc_collection_dialog/toc_collection_dialog.dart';

class TocAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BookData bookData;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const TocAppBar({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AppBar(
      leading: const CommonBackButton(),
      title: Text(
        bookData.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        PopupMenuButton(
          clipBehavior: Clip.hardEdge,
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return TocCollectionDialog(bookData: bookData);
                    },
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.collections_bookmark_outlined),
                  title: Text(appLocalizations.collectionTitle),
                  trailing: const SizedBox(width: 24.0),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
