import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonPopupMenuSortListTile extends StatelessWidget {
  final bool isSelected;
  final bool isAscending;
  final String title;

  const CommonPopupMenuSortListTile({
    super.key,
    required this.isSelected,
    required this.isAscending,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: isSelected
          ? const Icon(Icons.check_rounded)
          : const SizedBox(width: 24.0),
      title: Text(title),
      trailing: isSelected
          ? Icon(isAscending
              ? CupertinoIcons.chevron_up
              : CupertinoIcons.chevron_down)
          : const SizedBox(width: 24.0),
    );
  }
}
