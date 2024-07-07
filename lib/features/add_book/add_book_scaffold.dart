import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/window_class.dart';
import '../common_components/common_back_button.dart';
import 'bloc/add_book_form_bloc.dart';
import 'widgets/add_book_image_picker.dart';
import 'widgets/add_book_name_input_field.dart';
import 'widgets/add_book_submit_button.dart';

class AddBookScaffold extends StatelessWidget {
  const AddBookScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClassExtension.getClassByWidth(MediaQuery.of(context).size.width);
    final Widget bodyWidget;

    switch (windowClass) {
      case WindowClass.compact:
        bodyWidget = const AddBookScaffoldCompactView();
        break;
      default:
        bodyWidget = const AddBookScaffoldMediumView();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(AppLocalizations.of(context)!.titleAddBook),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocProvider(
              create: (_) => AddBookFormCubit(),
              child: bodyWidget,
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

class AddBookScaffoldMediumView extends StatelessWidget {
  const AddBookScaffoldMediumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 16.0),
                        width: constraints.maxWidth / 2,
                        child: const AddBookNameInputField(),
                      ),
                      const Expanded(
                        child: AddBookImagePicker(),
                      ),
                    ],
                  );
                },
              ),
            ),
            const AddBookSubmitButton(),
          ],
        ),
      ),
    );
  }
}