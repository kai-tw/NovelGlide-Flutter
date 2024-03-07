import 'package:flutter/material.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({this.onPressed, super.key});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();

        if (onPressed != null) {
          onPressed!();
        }
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }
}