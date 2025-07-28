part of '../reader.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);

    cubit.sendThemeData(Theme.of(context));

    switch (windowClass) {
      case WindowSize.compact:
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
      appBar: ReaderAppBar(),
      body: SafeArea(
        child: ReaderScaffoldBody(),
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
      appBar: ReaderAppBar(),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            ReaderNavigationRail(),
            Expanded(child: ReaderScaffoldBody()),
          ],
        ),
      ),
    );
  }
}
