part of '../developer_page.dart';

class _DeviceInfoCard extends StatelessWidget {
  const _DeviceInfoCard();

  @override
  Widget build(BuildContext context) {
    return _CardTemplate(
      children: <Widget>[
        ListTile(
          title: const Text('Device'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        ListTile(
          title: const Text('devicePixelRatio'),
          subtitle: Text('${MediaQuery.devicePixelRatioOf(context)}'),
        ),
        ListTile(
          title: const Text('size.width'),
          subtitle: Text('${MediaQuery.sizeOf(context).width}'),
        ),
        ListTile(
          title: const Text('size.height'),
          subtitle: Text('${MediaQuery.sizeOf(context).height}'),
        ),
        ListTile(
          title: const Text('Orientation'),
          subtitle: Text('${MediaQuery.orientationOf(context)}'),
        ),
        ListTile(
          title: const Text('Platform brightness'),
          subtitle: Text('${MediaQuery.of(context).platformBrightness}'),
        ),
        ListTile(
          title: const Text('WindowClass'),
          subtitle: Text('${WindowSize.of(context)}'),
        ),
      ],
    );
  }
}
