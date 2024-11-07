part of '../reset_page.dart';

class _ListTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String? deleteLabel;
  final Future<void> Function()? onDelete;

  const _ListTile({
    required this.title,
    required this.iconData,
    this.deleteLabel,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => CommonDeleteDialog(
            title: title,
            deleteIcon: iconData,
            deleteLabel: deleteLabel,
            onDelete: () => onDelete?.call().then((_) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (_) => const CommonSuccessDialog(),
                );
              }
            }),
          ),
        );
      },
      leading: Icon(iconData),
      title: Text(title),
    );
  }

// TODO: Remove
// void _showSuccessSnackBar(BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         appLocalizations.resetPageResetSuccessfully,
//       ),
//     ),
//   );
// }
}
