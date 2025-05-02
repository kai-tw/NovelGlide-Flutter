part of '../homepage.dart';

class HomepageCompactView extends StatelessWidget {
  const HomepageCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const _AppBar(),
      body: const _ScaffoldBody(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 64.0,
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
          decoration: BoxDecoration(
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
          child: const _NavigationBar(),
        ),
      ),
      floatingActionButton: const _FloatingActionWidget(),
    );
  }
}
