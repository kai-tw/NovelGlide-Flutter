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
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: const Size.fromHeight(48),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      icon: Icon(iconData, size: 24),
      label: Text(label),
    );
  }
}
