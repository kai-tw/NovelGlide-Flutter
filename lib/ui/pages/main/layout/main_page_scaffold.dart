import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation.dart';
import 'package:novelglide/ui/pages/main/layout/main_page_body_widget.dart';
import 'package:novelglide/ui/pages/main/layout/main_page_app_bar.dart';
import 'package:novelglide/ui/pages/main/layout/main_page_fab.dart';
import 'package:novelglide/ui/pages/main/layout/main_page_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NavigationCubit(),
        child: Scaffold(
            appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.background, title: const MainPageAppBar()),
            body: const MainPageBodyWidget(),
            floatingActionButton: const MainPageFab(),
            bottomNavigationBar: const MainPageNavigationBar()));
  }
}
