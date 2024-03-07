import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/book_object.dart';
import '../common_image_picker/common_image_picker.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookSliverImagePicker extends StatelessWidget {
  const AddBookSliverImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final BookObject data = BlocProvider.of<AddBookFormCubit>(context).data;
    return BlocBuilder<AddBookFormCubit, AddBookFormState>(builder: (BuildContext context, AddBookFormState state) {
      return SliverToBoxAdapter(
        child: CommonImagePicker(
          labelText: AppLocalizations.of(context)!.book_cover + AppLocalizations.of(context)!.input_optional,
          aspectRatio: 1.5,
          onSaved: (imageFile) => data.coverFile = imageFile,
        ),
      );
    });
  }
}
