import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared_bloc/common_file_picker_bloc.dart';
import '../common_image_picker/common_image_picker_button_list.dart';
import '../common_image_picker/common_image_picker_preview.dart';

class CommonImagePickerContent extends StatelessWidget {
  const CommonImagePickerContent(
      {required this.labelText, this.aspectRatio = 1, this.imageFile, super.key, this.onSaved});

  final String labelText;
  final double aspectRatio;
  final File? imageFile;

  final void Function(File?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    return FormField(
      validator: (_) => _validator(cubit.file),
      builder: (_) => InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 16),
          contentPadding: const EdgeInsets.all(24.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          children: [
            CommonImagePickerPreview(aspectRatio: aspectRatio),
            const Padding(padding: EdgeInsets.only(right: 16.0)),
            const Expanded(
              child: CommonImagePickerButtonList(),
            ),
          ],
        ),
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
