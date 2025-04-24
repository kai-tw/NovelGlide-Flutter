part of '../developer_page.dart';

class _BackupCard extends StatelessWidget {
  const _BackupCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: <Widget>[
        ListTile(
          title: const Text('Backup'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          onTap: () async {
            showDialog(
              context: context,
              builder: (_) => const _BackupProgressDialog(),
            );
          },
          leading: const Icon(Icons.backup),
          title: const Text('Create Backup'),
        ),
      ],
    );
  }
}
