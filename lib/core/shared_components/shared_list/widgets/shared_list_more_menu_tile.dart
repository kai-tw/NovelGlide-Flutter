part of '../shared_list.dart';

class SharedListMoreMenuTile extends StatelessWidget {
  const SharedListMoreMenuTile({
    super.key,
    required this.title,
    this.isSelected,
    this.trailing,
  });

  final bool? isSelected;
  final Widget? trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: isSelected == true
          ? const Icon(Icons.check_rounded)
          : const SizedBox(width: 24.0),
      title: Text(title),
      trailing: trailing ?? const SizedBox(width: 24.0),
    );
  }
}
