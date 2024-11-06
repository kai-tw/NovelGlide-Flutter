part of '../reset_page.dart';

class _ResetTile extends StatelessWidget {
  final String title;
  final Future<void> Function()? onDelete;

  const _ResetTile({
    required this.title,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => CommonDeleteDialog(
            title: title,
            deleteIcon: Icons.refresh_rounded,
            deleteLabel: appLocalizations.generalReset,
            onDelete: () => onDelete?.call().then((_) {
              if (context.mounted) {
                _showSuccessSnackBar(context);
              }
            }),
          ),
        );
      },
      leading: const Icon(Icons.refresh_rounded),
      title: Text(title),
    );
  }

  void _showSuccessSnackBar(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          appLocalizations.resetPageResetSuccessfully,
        ),
      ),
    );
  }
}
