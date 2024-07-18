import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_back_button.dart';
import '../bloc/reader_cubit.dart';
import '../reader_body.dart';
import '../reader_navigation.dart';
import '../widgets/reader_title.dart';

class ReaderScaffoldMediumView extends StatelessWidget {
  const ReaderScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: CommonBackButton(
          onPressed: () {
            if (cubit.state.readerSettings.autoSave) {
              cubit.saveBookmark();
            }
            Navigator.of(context).pop();
          },
        ),
        title: const ReaderTitle(),
      ),
      body: const SafeArea(
        child: Row(
          children: [
            ReaderNavigation(),
            Expanded(child: ReaderBody()),
          ],
        ),
      ),
    );
  }
}