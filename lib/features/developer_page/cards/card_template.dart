part of '../developer_page.dart';

class _CardTemplate extends StatelessWidget {
  final List<Widget> children;

  const _CardTemplate({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}