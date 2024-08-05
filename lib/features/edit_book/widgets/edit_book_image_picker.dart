import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common_components/common_image_picker/common_image_picker.dart';
import '../bloc/edit_book_form_bloc.dart';

class EditBookImagePicker extends StatelessWidget {
  const EditBookImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final EditBookFormCubit cubit = BlocProvider.of<EditBookFormCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return CommonImagePicker(
      inputDecoration: InputDecoration(
        labelText: appLocalizations.fieldBookCover + appLocalizations.fieldOptional,
      ),
      aspectRatio: 1.5,
      imageFile: cubit.oldData.coverFile,
      isRequired: false,
      onSaved: (imageFile) => cubit.newData.coverFile = imageFile,
    );
  }
}