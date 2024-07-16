import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/homepage_bloc.dart';
import '../homepage_app_bar.dart';
import '../homepage_scaffold_body.dart';
import '../widgets/homepage_floating_action_button.dart';
import '../widgets/homepage_navigation_rail.dart';

class HomepageScaffoldMediumView extends StatelessWidget {
  const HomepageScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(
      builder: (BuildContext context, HomepageState homepageState) {
        return Scaffold(
          extendBody: true,
          appBar: const HomepageAppBar(),
          body: SafeArea(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
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
          floatingActionButton: const HomepageFloatingActionButton(),
        );
      },
    );
  }
}
