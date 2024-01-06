import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';
import 'package:novelglide/ui/pages/main/bloc/navigation.dart';
import 'package:novelglide/ui/pages/main/layout/body.dart';
import 'package:novelglide/ui/pages/main/layout/app_bar/main.dart';
import 'package:novelglide/ui/pages/main/layout/fab.dart';
import 'package:novelglide/ui/pages/main/layout/nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => NavigationCubit()), BlocProvider(create: (_) => LibraryBookListCubit())],
      child: const Scaffold(
        appBar: MainPageAppBar(),
        body: MainPageBodyWidget(),
        floatingActionButton: MainPageFab(),
        bottomNavigationBar: MainPageNavBar(),
      ),
    );
  }
}
