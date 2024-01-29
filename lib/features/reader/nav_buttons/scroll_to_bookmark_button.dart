import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';

class ReaderNavScrollToBookmarkButton extends StatelessWidget {
  const ReaderNavScrollToBookmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return IconButton(
      onPressed: () {
        readerCubit.scrollToLastRead();
      },
      icon: const Icon(Icons.bookmark_rounded),
    );
  }
}
