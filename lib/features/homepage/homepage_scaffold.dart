import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ad_center/advertisement.dart';
import '../../ad_center/advertisement_id.dart';
import '../../binding_center/binding_center.dart';
import '../../processor/theme_processor.dart';
import 'bloc/navigation_bloc.dart';
import 'homepage_body.dart';
import 'homepage_nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: ThemeSwitcher(
        builder: (context) {
          ThemeBinding.instance.addBrightnessListener("ThemeManager", (_) {
            ThemeProcessor.onBrightnessChanged(context);
          });

          return BlocProvider(
            create: (_) => NavigationCubit(),
            child: Scaffold(
              body: Column(
                children: [
                  const Expanded(
                    child: HomepageBody(),
                  ),
                  Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
                ],
              ),
              bottomNavigationBar: const HomepageNavBar(),
            ),
          );
        },
      ),
    );
  }
}
