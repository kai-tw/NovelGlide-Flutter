import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import 'bloc/add_book_form_bloc.dart';
import 'widgets/add_book_image_picker.dart';
import 'widgets/add_book_name_input_field.dart';
import 'widgets/add_book_submit_button.dart';

class AddBookScaffold extends StatelessWidget {
  const AddBookScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(AppLocalizations.of(context)!.titleAddBook),
        ),
        body: BlocProvider(
          create: (_) => AddBookFormCubit(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: const AddBookScaffoldCompactView(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddBookScaffoldCompactView extends StatelessWidget {
  const AddBookScaffoldCompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 32.0),
          child: AddBookNameInputField(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 32.0),
          child: AddBookImagePicker(),
        ),
        AddBookSubmitButton(),
      ],
    );
  }
}
