part of '../developer_page.dart';

class _DeviceInfoCard extends StatelessWidget {
  const _DeviceInfoCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: [
        ListTile(
          title: const Text('Device'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          title: const Text('devicePixelRatio'),
          subtitle: Text("${MediaQuery.of(context).devicePixelRatio}"),
        ),
        ListTile(
          title: const Text('size.width'),
          subtitle: Text("${MediaQuery.of(context).size.width}"),
        ),
        ListTile(
          title: const Text('size.height'),
          subtitle: Text("${MediaQuery.of(context).size.height}"),
        ),
        ListTile(
          title: const Text('Orientation'),
          subtitle: Text("${MediaQuery.of(context).orientation}"),
        ),
        ListTile(
          title: const Text('Platform brightness'),
          subtitle: Text("${MediaQuery.of(context).platformBrightness}"),
        ),
      ],
    );
  }
}
