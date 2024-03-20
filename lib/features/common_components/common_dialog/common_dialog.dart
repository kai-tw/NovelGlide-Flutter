import 'package:flutter/material.dart';

import 'common_dialog_close_button.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    required this.content,
    this.contentAlign = TextAlign.left,
    this.title,
    this.iconData,
    this.actions,
    super.key,
    this.showCloseButton = false,
  });

  final String content;
  final TextAlign contentAlign;
  final String? title;
  final IconData? iconData;
  final bool showCloseButton;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final List<Widget> defaultActions = [const CommonDialogCloseButton()];
    return AlertDialog(
      title: title == null ? null : Text(title!),
      icon: iconData == null ? null : Icon(iconData, size: 40.0),
      content: Text(content, textAlign: contentAlign),
      actions: actions ?? defaultActions,
    );
  }
}
