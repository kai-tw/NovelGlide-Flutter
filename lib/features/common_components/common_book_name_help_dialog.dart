import 'package:flutter/material.dart';

import 'common_dialog/common_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonBookNameHelpDialog extends StatelessWidget {
  const CommonBookNameHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: AppLocalizations.of(context)!.book_name_rule_title,
      content: '${AppLocalizations.of(context)!.book_name_rule_content}_ -.,&()@#\$%^+=[{]};\'~`<>?|',
    );
  }
}
