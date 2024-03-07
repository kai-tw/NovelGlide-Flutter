import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/common_image_picker_bloc.dart';
import 'common_image_picker_content.dart';
import 'common_image_picker_delete_button.dart';
import 'common_image_picker_select_button.dart';

class CommonImagePicker extends StatelessWidget {
  const CommonImagePicker({required this.labelText, this.aspectRatio = 1, this.imageFile, this.onSaved, super.key});

  final String labelText;
  final double aspectRatio;
  final File? imageFile;
  final void Function(File?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommonImagePickerCubit(imageFile: imageFile),
      child: BlocBuilder<CommonImagePickerCubit, CommonImagePickerState>(
        builder: (BuildContext context, CommonImagePickerState pickerState) {
          return FormField(
            validator: (_) => _validator(pickerState.imageFile),
            builder: (FormFieldState state) {
              List<Widget> buttonList = [const CommonImagePickerSelectButton()];

              if (pickerState.imageFile != null) {
                buttonList.add(const CommonImagePickerDeleteButton());
              }

              return CommonImagePickerContent(
                labelText: labelText,
                buttonList: buttonList,
                aspectRatio: aspectRatio,
                imageFile: pickerState.imageFile,
              );
            },
          );
        },
      ),
    );
  }

  String? _validator(File? imageFile) {
    if (onSaved != null) {
      onSaved!(imageFile);
    }
    return null;
  }
}
