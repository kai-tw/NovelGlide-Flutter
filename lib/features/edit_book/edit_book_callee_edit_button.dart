import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_data.dart';
import 'bloc/edit_book_form_bloc.dart';
import 'edit_book_scaffold.dart';

class EditBookCalleeEditButton extends StatelessWidget {
  const EditBookCalleeEditButton({required this.bookObject, this.onPopBack, super.key});

  final BookData bookObject;
  final void Function(dynamic)? onPopBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => EditBookFormCubit(bookObject),
              child: const EditBookScaffold(),
            ),
          ),
        ).then(onPopBack ?? (_) {});
      },
      icon: const Icon(Icons.edit_rounded),
    );
  }
}