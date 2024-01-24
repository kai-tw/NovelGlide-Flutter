import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/form_bloc.dart';
import 'sliver_image_picker.dart';
import 'sliver_name_text_field.dart';
import 'sliver_submit_button.dart';
import 'sliver_title.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AddBookFormCubit()),
      ],
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.25,
        maxChildSize: 1.0,
        expand: false,
        snap: true,
        snapSizes: const [0.6],
        builder: (BuildContext context, ScrollController controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: CustomScrollView(
                controller: controller,
                slivers: const [
                  AddBookSliverTitle(),
                  SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
                  AddBookSliverNameTextField(),
                  SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
                  AddBookSliverImagePicker(),
                  SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
                  AddBookSliverSubmitButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
