import 'package:flutter/material.dart';

class CommonSuccessDialog extends StatelessWidget {
  const CommonSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.check_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.secondary,
    );
  }
}