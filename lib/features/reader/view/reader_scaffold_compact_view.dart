import 'package:flutter/material.dart';

import '../nav/reader_navigation_bar.dart';
import '../reader_app_bar.dart';
import '../reader_body.dart';

class ReaderScaffoldCompactView extends StatelessWidget {
  const ReaderScaffoldCompactView({super.key});

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
