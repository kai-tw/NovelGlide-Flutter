part of '../developer_page.dart';

class _GoogleDriveCard extends StatelessWidget {
  const _GoogleDriveCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: <Widget>[
        ListTile(
          title: const Text('Google Drive'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          onTap: () => Navigator.of(context).push(
            RouteUtils.pushRoute(const _GoogleDriveFileManager()),
          ),
          leading: const Icon(Icons.folder),
          title: const Text('File Browser'),
        ),
      ],
    );
  }
}
