import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/book_object.dart';
import '../common_image_picker/common_image_picker.dart';
import 'bloc/edit_book_form_bloc.dart';

class EditBookSliverImagePicker extends StatelessWidget {
  const EditBookSliverImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    BookObject data = BlocProvider.of<EditBookFormCubit>(context).data;
    return SliverToBoxAdapter(
      child: CommonImagePicker(
        labelText: AppLocalizations.of(context)!.book_cover + AppLocalizations.of(context)!.input_optional,
        aspectRatio: 1.5,
        imageFile: data.coverFile,
        onSaved: (imageFile) => data.coverFile = imageFile,
      ),
    );
  }
}