import 'package:flutter/material.dart';

import '../../enum/window_class.dart';
import 'nav/reader_navigation_bar.dart';
import 'nav/reader_navigation_rail.dart';
import 'reader_app_bar.dart';
import 'reader_body.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);

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
      appBar: ReaderAppBar(),
      body: SafeArea(
        child: ReaderBody(),
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
          children: [
            ReaderNavigationRail(),
            Expanded(child: ReaderBody()),
          ],
        ),
      ),
    );
  }
}
