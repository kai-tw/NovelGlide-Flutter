import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_cubit.dart';

class ReaderSliverAppBar extends StatelessWidget {
  const ReaderSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          BlocProvider.of<ReaderCubit>(context).saveBookmark();
          BlocProvider.of<ReaderCubit>(context).dispose();
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      surfaceTintColor: Theme.of(context).colorScheme.background,
      pinned: true,
    );
  }
}
