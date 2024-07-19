import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? leading;
  final Color? color;

  const CommonListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.leading,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [
      Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
      ),
    ];

    List<Widget> rowChildren = [Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren,
        ),
      ),
    )];

    if (leading != null) {
      rowChildren.insert(0, leading!);
    }

    if (subtitle != null) {
      columnChildren.add(Text(
        subtitle!,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      ));
    }

    if (description != null) {
      columnChildren.add(Text(
        description!,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ));
    }

    return Row(children: rowChildren);
  }
}
