import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common_confirm_dialog.dart';

class CommonDeleteConfirmDialog extends StatelessWidget {
  const CommonDeleteConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonConfirmDialog(
      iconData: Icons.delete_forever,
      content: AppLocalizations.of(context)!.confirm_content_delete,
      yesString: AppLocalizations.of(context)!.delete,
      yesColor: Theme.of(context).colorScheme.error,
      noString: AppLocalizations.of(context)!.cancel,
    );
  }
}