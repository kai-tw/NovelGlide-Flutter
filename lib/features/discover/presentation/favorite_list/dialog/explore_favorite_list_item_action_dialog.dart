import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../../shared_components/common_delete_dialog.dart';
import '../../browser/cubits/explore_browser_cubit.dart';

class ExploreFavoriteListItemActionDialog extends StatelessWidget {
  const ExploreFavoriteListItemActionDialog({
    super.key,
    required this.identifier,
  });

  final String identifier;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.delete_rounded),
            title: Text(appLocalizations.discoverRemoveFromFavorites),
            onTap: () => _showConfirmDialog(context),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    final ExploreBrowserCubit browserCubit =
        BlocProvider.of<ExploreBrowserCubit>(context);
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
