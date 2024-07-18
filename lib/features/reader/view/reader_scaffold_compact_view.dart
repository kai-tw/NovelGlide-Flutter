import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_back_button.dart';
import '../bloc/reader_cubit.dart';
import '../reader_body.dart';
import '../reader_navigation.dart';
import '../widgets/reader_title.dart';

class ReaderScaffoldCompactView extends StatelessWidget {
  const ReaderScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonBackButton(
          onPressed: () {
            BlocProvider.of<ReaderCubit>(context).autoSaveBookmark();
            Navigator.of(context).pop();
          },
        ),
        title: const ReaderTitle(),
      ),
      body: const SafeArea(
        child: ReaderBody(),
      ),
      bottomNavigationBar: const SafeArea(child: ReaderNavigation()),
    );
  }
}
