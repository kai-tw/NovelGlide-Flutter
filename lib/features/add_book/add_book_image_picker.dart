import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/book_object.dart';
import '../common_components/common_image_picker/common_image_picker.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookImagePicker extends StatelessWidget {
  const AddBookImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final BookObject data = BlocProvider.of<AddBookFormCubit>(context).data;
    return CommonImagePicker(
      labelText: AppLocalizations.of(context)!.bookCover + AppLocalizations.of(context)!.fieldOptional,
      aspectRatio: 1.5,
      onSaved: (imageFile) => data.coverFile = imageFile,
    );
  }
}
