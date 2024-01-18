import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:novelglide/features/edit_book/sliver_image_picker.dart';
import 'package:novelglide/features/edit_book/sliver_submit_button.dart';

import '../../shared/book_process.dart';
import 'bloc/form_bloc.dart';
import 'sliver_name_text_field.dart';
import 'sliver_title.dart';

class EditBookPage extends StatelessWidget {
  EditBookPage(this.bookObject, {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EditBookFormCubit(bookObject)),
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
              child: BlocBuilder<EditBookFormCubit, EditBookFormState>(
                builder: (BuildContext context, EditBookFormState state) {
                  return CustomScrollView(
                    controller: controller,
                    slivers: [
                      const EditBookSliverTitle(),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
                      const EditBookSliverNameTextField(),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
                      const EditBookSliverImagePicker(),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
                      EditBookSliverSubmitButton(_formKey),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
