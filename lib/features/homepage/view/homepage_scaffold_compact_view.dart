import 'package:flutter/material.dart';

import '../homepage_app_bar.dart';
import '../homepage_scaffold_body.dart';
import '../homepage_tab_section.dart';
import '../widgets/homepage_navigation_bar.dart';

class HomepageScaffoldCompactView extends StatelessWidget {
  const HomepageScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const HomepageAppBar(),
      body: const HomepageScaffoldBody(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 64.0,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                blurRadius: 16.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: const HomepageNavigationBar(),
        ),
      ),
      floatingActionButton: const HomepageTabSection(),
    );
  }
}
