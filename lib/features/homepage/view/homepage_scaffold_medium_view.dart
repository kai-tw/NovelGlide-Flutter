import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/homepage_bloc.dart';
import '../homepage_app_bar.dart';
import '../homepage_nav_bar.dart';
import '../homepage_scaffold_body.dart';
import '../widgets/homepage_dragging_target_bar.dart';
import '../widgets/homepage_floating_action_button.dart';

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
                const HomepageNavBar(),
                Expanded(
                  child: Stack(
                    children: [
                      const HomepageScaffoldBody(),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
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
                            child: homepageState.isDragging ? const HomepageDraggingTargetBar() : null,
                          ),
                        ),
                      )
                    ],
                  ),
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
