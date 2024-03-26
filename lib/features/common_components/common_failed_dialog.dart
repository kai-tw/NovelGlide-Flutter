import 'package:flutter/material.dart';

class CommonFailedDialog extends StatelessWidget {
  const CommonFailedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.close_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.error,
    );
  }
}