import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_add_bloc.dart';

class BookAddFileInfoWidget extends StatelessWidget {
  const BookAddFileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAddCubit, BookAddState>(
      buildWhen: (previous, current) =>
          previous.file != current.file ||
          previous.fileName != current.fileName ||
          previous.fileSize != current.fileSize,
      builder: (context, state) {
        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 16.0),
          leading: const Icon(Icons.book_outlined, size: 48),
          title: Text(
            state.fileName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(state.fileSize),
        );
      },
    );
  }
}
