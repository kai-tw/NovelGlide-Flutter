import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_back_button.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';
import 'search/reader_search_btn.dart';
import 'widgets/reader_title.dart';

class ReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const ReaderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit cubit = BlocProvider.of<ReaderCubit>(context);
    return AppBar(
      leading: CommonBackButton(
        onPressed: () {
          if (cubit.state.code == ReaderStateCode.search) {
            cubit.closeSearch();
          } else {
            Navigator.of(context).pop();
          }
        }
      ),
      title: const ReaderTitle(),
      actions: const [
        ReaderSearchBtn(),
      ],
    );
  }
}