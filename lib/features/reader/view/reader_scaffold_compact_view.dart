import 'package:flutter/material.dart';

import '../../common_components/common_back_button.dart';
import '../reader_body.dart';
import '../reader_navigation.dart';
import '../widgets/reader_title.dart';

class ReaderScaffoldCompactView extends StatelessWidget {
  const ReaderScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const ReaderTitle(),
      ),
      body: const SafeArea(
        child: ReaderBody(),
      ),
      bottomNavigationBar: const ReaderNavigation(),
    );
  }
}