import 'package:flutter/material.dart';

class SettingPageButton extends StatelessWidget {
  const SettingPageButton({
    super.key,
    required this.iconData,
    required this.label,
    this.onPressed,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: const Size.fromHeight(48),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(iconData, semanticLabel: label),
          ),
          Text(label),
        ],
      ),
    );
  }
}
