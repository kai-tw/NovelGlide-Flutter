part of '../reader.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClass.fromWidth(windowWidth);
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);

    cubit.sendThemeData(Theme.of(context));

    switch (windowClass) {
      case WindowClass.compact:
        return const _CompactView();

      default:
        return const _MediumView();
    }
  }
}

class _CompactView extends StatelessWidget {
  const _CompactView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: SafeArea(
        child: _ScaffoldBody(),
      ),
      bottomNavigationBar: SafeArea(child: ReaderNavigationBar()),
    );
  }
}

class _MediumView extends StatelessWidget {
  const _MediumView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            ReaderNavigationRail(),
            Expanded(child: _ScaffoldBody()),
          ],
        ),
      ),
    );
  }
}
