import 'package:flutter/material.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({this.onPressed, super.key, this.popValue});

  final dynamic popValue;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop(popValue);

        if (onPressed != null) {
          onPressed!();
        }
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }
}