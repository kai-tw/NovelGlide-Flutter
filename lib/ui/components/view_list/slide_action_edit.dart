import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideActionEdit extends StatelessWidget {
  const SlideActionEdit({super.key, this.onPressed});

  final void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      padding: const EdgeInsets.all(16.0),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      icon: Icons.edit_rounded,
      onPressed: onPressed,
    );
  }

}