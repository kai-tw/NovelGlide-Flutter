import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/add_book/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/add_book/layout/form_components/input_book_name.dart';
import 'package:novelglide/ui/pages/add_book/layout/form_components/submit_button.dart';

class AddBookFormWidget extends StatelessWidget {
  AddBookFormWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: BlocProvider(
                    create: (_) => AddBookFormCubit(),
                    child: const Column(
                      children: [
                        AddBookInputBookName(),
                        SizedBox(height: 24),
                        AddBookSubmitButton()
                      ],
                    )))));
  }
}
