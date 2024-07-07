import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../common_delete_confirm_dialog.dart';

class CommonSlidableActionDelete extends StatelessWidget {
  final void Function()? onDelete;

  const CommonSlidableActionDelete({super.key, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (_) {
        showDialog(context: context, builder: (_) => const CommonDeleteConfirmDialog()).then((isDelete) {
          if (isDelete && onDelete != null) {
            onDelete!();
          }
        });
      },
      backgroundColor: Theme.of(context).colorScheme.error,
      foregroundColor: Theme.of(context).colorScheme.onError,
      icon: Icons.delete_outline_rounded,
      borderRadius: BorderRadius.circular(16.0),
    );
  }
}