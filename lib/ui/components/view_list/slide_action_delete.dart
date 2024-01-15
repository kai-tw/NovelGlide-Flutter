import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideActionDelete extends StatelessWidget {
  const SlideActionDelete({super.key, this.onPressed});

  final void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      padding: const EdgeInsets.all(16.0),
      backgroundColor: Theme.of(context).colorScheme.error,
      foregroundColor: Theme.of(context).colorScheme.onError,
      icon: Icons.delete_outline_rounded,
      onPressed: onPressed,
    );
  }

}