import 'package:flutter/material.dart';

import '../homepage_app_bar.dart';
import '../homepage_nav_bar.dart';
import '../homepage_scaffold_body.dart';
import '../homepage_tab_section.dart';

class HomepageScaffoldCompactView extends StatelessWidget {
  const HomepageScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      appBar: HomepageAppBar(),
      body: HomepageScaffoldBody(),
      bottomNavigationBar: SafeArea(child: HomepageNavBar()),
      floatingActionButton: HomepageTabSection(),
    );
  }
}
