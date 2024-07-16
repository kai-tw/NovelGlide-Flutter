import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/homepage_bloc.dart';
import '../homepage_app_bar.dart';
import '../homepage_nav_bar.dart';
import '../homepage_scaffold_body.dart';
import '../widgets/homepage_dragging_target_bar.dart';
import '../widgets/homepage_floating_action_button.dart';

class HomepageScaffoldCompactView extends StatelessWidget {
  const HomepageScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(
      builder: (BuildContext context, HomepageState homepageState) {
        return Scaffold(
          extendBody: true,
          appBar: const HomepageAppBar(),
          body: const HomepageScaffoldBody(),
          bottomNavigationBar: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized)).animate(animation),
                  child: child,
                );
              },
              child: homepageState.isDragging ? const HomepageDraggingTargetBar() : const HomepageNavBar(),
            ),
          ),
          floatingActionButton: const HomepageFloatingActionButton(),
        );
      },
    );
  }
}
