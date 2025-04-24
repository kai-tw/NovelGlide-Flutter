part of '../reset_page.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.title,
    required this.iconData,
    this.deleteLabel,
    this.isDangerous = true,
    this.onDelete,
  });

  final String title;
  final IconData iconData;
  final String? deleteLabel;
  final bool isDangerous;
  final Future<void> Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (isDangerous) {
          showDialog(
            context: context,
            builder: (_) => CommonDeleteDialog(
              title: title,
              deleteIcon: iconData,
              deleteLabel: deleteLabel,
              onDelete: () => _performDeletion(context),
            ),
          );
        } else {
          _performDeletion(context);
        }
      },
      leading: Icon(iconData),
      title: Text(title),
    );
  }

  void _performDeletion(BuildContext context) {
    onDelete?.call().then((_) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => const CommonSuccessDialog(),
        );
      }
    });
  }
}
