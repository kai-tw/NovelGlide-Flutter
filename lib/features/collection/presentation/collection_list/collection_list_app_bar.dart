import 'package:flutter/material.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../../homepage/homepage.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'cubit/collection_list_cubit.dart';
import 'widgets/collection_list_app_bar_more_button.dart';

class CollectionListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CollectionListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return HomepageAppBar(
      iconData: Icons.collections_bookmark_rounded,
      title: appLocalizations.generalCollection(2),
      actions: const <Widget>[
        SharedListSelectAllButton<CollectionListCubit>(),
        SharedListDoneButton<CollectionListCubit>(),
        CollectionListAppBarMoreButton(),
      ],
    );
  }
}
