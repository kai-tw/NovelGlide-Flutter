import 'package:flutter/material.dart';

import 'common_dialog/common_dialog.dart';

class CommonFormHelpButton extends StatelessWidget {
  const CommonFormHelpButton({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(context: context, builder: (_) => CommonDialog(
        title: title,
        content: content,
      )),
      icon: const Icon(Icons.help_outline_rounded),
    );
  }
}