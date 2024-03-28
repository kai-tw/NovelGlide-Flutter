import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_file_picker/bloc/common_file_picker_bloc.dart';
import '../common_file_picker/common_file_picker_form_field.dart';
import 'common_image_picker_content.dart';

class CommonImagePicker extends StatelessWidget {
  const CommonImagePicker({required this.labelText, this.aspectRatio = 1, this.imageFile, this.isRequired = true, this.onSaved, super.key});

  final String labelText;
  final double aspectRatio;
  final File? imageFile;
  final bool isRequired;
  final void Function(File?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommonFilePickerCubit(file: imageFile),
      child: CommonFilePickerFormField(
        labelText: labelText,
        onSaved: onSaved,
        isRequired: isRequired,
        child: CommonImagePickerContent(
          aspectRatio: aspectRatio,
        ),
      ),
    );
  }
}
