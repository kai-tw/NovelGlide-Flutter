part of '../developer_page.dart';

class _FirebaseCard extends StatelessWidget {
  const _FirebaseCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: <Widget>[
        ListTile(
          title: const Text('Firebase'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          onTap: () => FirebaseCrashlytics.instance.crash(),
          leading: const Icon(Icons.error_outline_rounded),
          title: const Text('Force crash'),
        ),
      ],
    );
  }
}
