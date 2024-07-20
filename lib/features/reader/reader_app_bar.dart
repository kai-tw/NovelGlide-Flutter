import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_back_button.dart';
import 'bloc/reader_cubit.dart';
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
          if (cubit.state.readerSettings.autoSave) {
            cubit.saveBookmark();
          }
          Navigator.of(context).pop();
        },
      ),
      title: const ReaderTitle(),
    );
  }
}