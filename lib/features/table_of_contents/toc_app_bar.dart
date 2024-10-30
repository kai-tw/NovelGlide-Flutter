import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../../utils/route_utils.dart';
import '../common_components/common_back_button.dart';
import '../toc_collection/toc_collection_scaffold.dart';

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
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              RouteUtils.pushRoute(
                TocCollectionScaffold(bookData: bookData),
              ),
            );
          },
          icon: Icon(
            Icons.collections_bookmark_outlined,
            semanticLabel: appLocalizations.collectionTitle,
          ),
        ),
      ],
    );
  }
}
