import 'package:flutter/material.dart';

import '../homepage_app_bar.dart';
import '../homepage_scaffold_body.dart';
import '../homepage_tab_section.dart';
import '../widgets/homepage_navigation_rail.dart';

class HomepageScaffoldMediumView extends StatelessWidget {
  const HomepageScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const HomepageAppBar(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(24.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: const HomepageNavigationRail(),
            ),
            const Expanded(
              child: HomepageScaffoldBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: const HomepageTabSection(),
    );
  }
}
