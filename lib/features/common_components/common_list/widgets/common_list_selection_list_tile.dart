part of '../common_list.dart';

class CommonListSelectionListTile extends StatelessWidget {
  final bool isSelecting;
  final bool isSelected;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  const CommonListSelectionListTile({
    super.key,
    this.isSelecting = false,
    this.isSelected = false,
    this.leading,
    this.title,
    this.subtitle,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const normalPadding = EdgeInsets.symmetric(horizontal: 12.0);
    if (isSelecting) {
      return CheckboxListTile(
        contentPadding: _compensatedPadding ?? normalPadding,
        value: isSelected,
        onChanged: onChanged,
        secondary: leading,
        title: title,
        subtitle: subtitle,
      );
    } else {
      return ListTile(
        contentPadding: normalPadding,
        onTap: onTap,
        leading: leading,
        title: title,
        subtitle: subtitle,
      );
    }
  }

  EdgeInsets? get _compensatedPadding {
    if (Platform.isIOS) {
      return const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      );
    }
    return null;
  }
}
