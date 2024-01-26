import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderNavAddBookmarkButton extends StatelessWidget {
  const ReaderNavAddBookmarkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: Icon(state.addBookmarkState ? Icons.bookmark_added_rounded : Icons.bookmark_add_rounded),
          disabledColor: Colors.green,
          onPressed: state.addBookmarkState ? null : () {
            readerCubit.saveBookmark();
          },
        );
      },
    );
  }
}
