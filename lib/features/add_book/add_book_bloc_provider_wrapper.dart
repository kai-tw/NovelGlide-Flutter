import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_book_form_bloc.dart';

class AddBookBlocProviderWrapper extends StatelessWidget {
  const AddBookBlocProviderWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBookFormCubit(),
      child: child,
    );
  }
}
