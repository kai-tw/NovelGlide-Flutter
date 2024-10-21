import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import 'widgets/collection_list_done_button.dart';
import 'widgets/collection_list_popup_menu_button.dart';
import 'widgets/collection_list_select_button.dart';

class CollectionListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CollectionListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.getClassByWidth(windowWidth);

    return AppBar(
      leading: const Icon(Icons.collections_bookmark_outlined),
      leadingWidth: windowClass == WindowClass.compact ? null : 100.0,
      title: Text(AppLocalizations.of(context)!.collectionTitle),
      actions: const [
        CollectionListSelectButton(),
        CollectionListDoneButton(),
        CollectionListPopupMenuButton(),
      ],
    );
  }
}
