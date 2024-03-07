import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common_dialog.dart';

class CommonConfirmDialog extends StatelessWidget {
  const CommonConfirmDialog({
    required this.content,
    this.iconData,
    this.yesString,
    this.yesColor,
    this.noString,
    this.noColor,
    this.isReversed = false,
    super.key,
  });

  final String content;
  final IconData? iconData;
  final String? yesString;
  final Color? yesColor;
  final String? noString;
  final Color? noColor;
  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        style: TextButton.styleFrom(foregroundColor: yesColor),
        child: Text(yesString ?? AppLocalizations.of(context)!.yes),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        style: TextButton.styleFrom(foregroundColor: noColor),
        child: Text(noString ?? AppLocalizations.of(context)!.no),
      ),
    ];

    if (isReversed) {
      actions = actions.reversed.toList();
    }

    return CommonDialog(
      iconData: iconData ?? Icons.question_mark_rounded,
      content: content,
      actions: actions,
    );
  }
}
