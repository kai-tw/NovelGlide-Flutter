import 'package:flutter/material.dart';

import '../nav/reader_navigation_rail.dart';
import '../reader_app_bar.dart';
import '../reader_body.dart';

class ReaderScaffoldMediumView extends StatelessWidget {
  const ReaderScaffoldMediumView({super.key});

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