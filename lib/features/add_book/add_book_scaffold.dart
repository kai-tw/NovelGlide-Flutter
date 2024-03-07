import 'package:flutter/material.dart';

import 'add_book_bloc_provider_wrapper.dart';
import 'add_book_form.dart';

class AddBookScaffold extends StatelessWidget {
  const AddBookScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return AddBookBlocProviderWrapper(
      child: Scaffold(
        body: AddBookForm(),
      ),
    );
  }
}
