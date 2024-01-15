import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/features/homepage/nav_bar.dart';

import 'bloc/navigation_bloc.dart';
import 'body.dart';
import 'fab.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: const Scaffold(
        body: HomepageBody(),
        floatingActionButton: HomepageFab(),
        bottomNavigationBar: HomepageNavBar(),
      ),
    );
  }
}
