import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final void Function()? onTap;
  final IconData iconData;
  final String title;

  const SettingsListTile({
    super.key,
    this.onTap,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(iconData),
      ),
      title: Text(title),
    );
  }
}
