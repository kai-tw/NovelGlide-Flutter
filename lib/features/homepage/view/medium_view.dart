part of '../homepage.dart';

class _MediumView extends StatelessWidget {
  const _MediumView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const _AppBar(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              decoration: BoxDecoration(
                // color: Colors.black87,
                borderRadius: BorderRadius.circular(36.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    blurRadius: 16.0,
                    spreadRadius: -10.0,
                    offset: const Offset(0.0, 8.0),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: const _NavigationRail(),
            ),
            const Expanded(
              child: _ScaffoldBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: const _FloatingActionWidget(),
    );
  }
}
