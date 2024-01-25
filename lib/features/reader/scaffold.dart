import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_cubit.dart';
import 'nav_bar.dart';
import 'sliver_app_bar.dart';
import 'sliver_content.dart';
import 'sliver_title.dart';

class ReaderScaffold extends StatelessWidget {
  const ReaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReaderCubit>(context).load();
    return const Scaffold(
      body: CustomScrollView(slivers: [
        ReaderSliverAppBar(),
        ReaderSliverTitle(),
        ReaderSliverContent(),
      ]),
      bottomNavigationBar: ReaderNavBar(),
    );
  }

}