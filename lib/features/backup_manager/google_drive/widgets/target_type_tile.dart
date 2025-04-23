part of '../backup_manager_google_drive.dart';

class _TargetTypeTile extends StatelessWidget {
  const _TargetTypeTile({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
