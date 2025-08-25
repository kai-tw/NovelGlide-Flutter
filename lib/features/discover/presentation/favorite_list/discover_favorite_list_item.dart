import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/discover_favorite_catalog_data.dart';
import '../browser/cubits/discover_browser_cubit.dart';
import 'dialog/discover_favorite_list_item_action_dialog.dart';

class DiscoverFavoriteListItem extends StatelessWidget {
  const DiscoverFavoriteListItem({super.key, required this.catalog});

  final DiscoverFavoriteCatalogData catalog;

  @override
  Widget build(BuildContext context) {
    final DiscoverBrowserCubit browserCubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);
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
    DiscoverBrowserCubit browserCubit,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<DiscoverBrowserCubit>.value(
          value: browserCubit,
          child: DiscoverFavoriteListItemActionDialog(
            identifier: catalog.identifier,
          ),
        );
      },
    );
  }
}
