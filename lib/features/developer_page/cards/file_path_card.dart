part of '../developer_page.dart';

class _FilePathCard extends StatelessWidget {
  const _FilePathCard();

  @override
  Widget build(BuildContext context) {
    final AppPathProvider pathProvider = sl<AppPathProvider>();
    return _CardTemplate(
      children: <Widget>[
        ListTile(
          title: const Text('File Paths'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          title: const Text('document'),
          subtitle: FutureBuilder<String>(
            future: pathProvider.documentPath,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return SimpleFadeSwitcher(
                child: snapshot.hasData ? Text(snapshot.data!) : null,
              );
            },
          ),
        ),
        ListTile(
          title: const Text('temp'),
          subtitle: FutureBuilder<String>(
            future: pathProvider.tempPath,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return SimpleFadeSwitcher(
                child: snapshot.hasData ? Text(snapshot.data!) : null,
              );
            },
          ),
        ),
        ListTile(
          title: const Text('cache'),
          subtitle: FutureBuilder<String>(
            future: pathProvider.cachePath,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return SimpleFadeSwitcher(
                child: snapshot.hasData ? Text(snapshot.data!) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
