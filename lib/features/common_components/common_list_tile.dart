import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? description;
  final Widget? leading;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? descriptionStyle;
  final Color? color;

  const CommonListTile({
    super.key,
    this.title,
    this.subtitle,
    this.description,
    this.leading,
    this.titleStyle,
    this.subtitleStyle,
    this.descriptionStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [];

    if (title != null) {
      columnChildren.add(Text(
        title!,
        style: titleStyle ?? Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
      ));
    }

    List<Widget> rowChildren = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnChildren,
          ),
        ),
      ),
    ];

    /// Insert leading widget if it is specified.
    if (leading != null) {
      rowChildren.insert(0, leading!);
    }

    /// Add subtitle if it is specified.
    if (subtitle != null) {
      columnChildren.add(Text(
        subtitle!,
        style: subtitleStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      ));
    }

    /// Add description if it is specified.
    if (description != null) {
      columnChildren.add(Text(
        description!,
        style: descriptionStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ));
    }

    return Row(children: rowChildren);
  }
}
