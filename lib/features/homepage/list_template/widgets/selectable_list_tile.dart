part of '../list_template.dart';

class CommonListSelectableListTile extends StatelessWidget {
  final bool isSelecting;
  final bool isSelected;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  const CommonListSelectableListTile({
    super.key,
    this.isSelecting = false,
    this.isSelected = false,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelecting) {
      return CheckboxListTile(
        value: isSelected,
        onChanged: onChanged,
        secondary: leading,
        title: title,
        subtitle: subtitle,
      );
    } else {
      return ListTile(
        onTap: onTap,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      );
    }
  }
}
