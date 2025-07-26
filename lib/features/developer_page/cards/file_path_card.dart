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
          title: const Text('document'),
          subtitle: _buildPathText(FileSystemService.document.rootDirectory),
        ),
        ListTile(
          title: const Text('temp'),
          subtitle: _buildPathText(FileSystemService.temp.rootDirectory),
        ),
        ListTile(
          title: const Text('cache'),
          subtitle: _buildPathText(FileSystemService.cache.rootDirectory),
        ),
      ],
    );
  }

  Widget _buildPathText(Future<Directory> future) {
    return FutureBuilder<Directory>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.path);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
