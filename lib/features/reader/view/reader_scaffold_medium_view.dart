import 'package:flutter/material.dart';

import '../reader_app_bar.dart';
import '../reader_body.dart';
import '../reader_navigation.dart';

class ReaderScaffoldMediumView extends StatelessWidget {
  const ReaderScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ReaderAppBar(),
      body: SafeArea(
        child: Row(
          children: [
            ReaderNavigation(),
            Expanded(child: ReaderBody()),
          ],
        ),
      ),
    );
  }
}