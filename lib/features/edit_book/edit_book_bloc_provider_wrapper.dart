import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_object.dart';
import 'bloc/edit_book_form_bloc.dart';

class EditBookBlocProviderWrapper extends StatelessWidget {
  const EditBookBlocProviderWrapper({required this.bookObject, required this.child, super.key});

  final BookObject bookObject;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditBookFormCubit(bookObject),
      child: child,
    );
  }
}
