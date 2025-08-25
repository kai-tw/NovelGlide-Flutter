import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared_components/common_delete_dialog.dart';
import '../../browser/cubits/discover_browser_cubit.dart';

class DiscoverFavoriteListItemActionDialog extends StatelessWidget {
  const DiscoverFavoriteListItemActionDialog({
    super.key,
    required this.identifier,
  });

  final String identifier;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Action'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.delete_rounded),
            title: const Text('Remove from favorite list'),
            onTap: () => _showConfirmDialog(context),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    final DiscoverBrowserCubit browserCubit =
        BlocProvider.of<DiscoverBrowserCubit>(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDeleteDialog(
          onAccept: () {
            browserCubit.removeFromFavoriteList(identifier);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
