part of '../developer_page.dart';

class _FilePathCard extends StatelessWidget {
  const _FilePathCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: <Widget>[
        ListTile(
          title: const Text('File Paths'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          title: const Text('libraryRoot'),
          subtitle: Text(FilePath.libraryRoot),
        ),
        ListTile(
          title: const Text('dataRoot'),
          subtitle: Text(FilePath.dataRoot),
        ),
        ListTile(
          title: const Text('tempFolder'),
          subtitle: Text(FilePath.tempFolder),
        ),
      ],
    );
  }
}
