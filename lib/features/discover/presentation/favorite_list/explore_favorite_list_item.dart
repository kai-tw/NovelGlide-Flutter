import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/explore_favorite_catalog_data.dart';
import '../browser/cubits/explore_browser_cubit.dart';
import 'dialog/explore_favorite_list_item_action_dialog.dart';

class ExploreFavoriteListItem extends StatelessWidget {
  const ExploreFavoriteListItem({super.key, required this.catalog});

  final ExploreFavoriteCatalogData catalog;

  @override
  Widget build(BuildContext context) {
    final ExploreBrowserCubit browserCubit =
        BlocProvider.of<ExploreBrowserCubit>(context);
    return ListTile(
      leading: const Icon(Icons.feed_rounded),
      title: Text(catalog.name),
      subtitle: Text(catalog.uri.toString()),
      onTap: () => browserCubit.browseCatalog(catalog.uri),
      onLongPress: () => _showActionDialog(context, browserCubit),
    );
  }

  void _showActionDialog(
    BuildContext context,
    ExploreBrowserCubit browserCubit,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<ExploreBrowserCubit>.value(
          value: browserCubit,
          child: ExploreFavoriteListItemActionDialog(
            identifier: catalog.identifier,
          ),
        );
      },
    );
  }
}
