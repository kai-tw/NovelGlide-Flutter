import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation_bloc.dart';
import 'homepage_body.dart';
import 'homepage_nav_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: const Scaffold(
        body: HomepageBody(),
        bottomNavigationBar: HomepageNavBar(),
      ),
    );
  }
}
