import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_chapter_scaffold.dart';
import 'bloc/add_chapter_form_bloc.dart';

class AddChapterCalleeAddButton extends StatelessWidget {
  const AddChapterCalleeAddButton(this.bookName, {super.key, this.onPopBack});

  final String bookName;
  final void Function(dynamic)? onPopBack;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => BlocProvider(
            create: (_) => AddChapterFormCubit(bookName),
            child: const AddChapterScaffold(),
          ))
        ).then(onPopBack ?? (_) {});
      },
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add_rounded, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}