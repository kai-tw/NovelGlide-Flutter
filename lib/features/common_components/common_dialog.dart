import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({required this.content, this.iconData, this.actions, super.key});

  final String content;
  final IconData? iconData;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: iconData == null ? null : Icon(iconData, size: 40.0),
      content: Text(content, textAlign: TextAlign.center),
      actions: actions,
    );
  }
}
