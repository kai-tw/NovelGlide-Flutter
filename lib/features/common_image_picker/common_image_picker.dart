import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/common_image_picker_bloc.dart';
import 'common_image_picker_content.dart';

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
      child: CommonImagePickerContent(
        labelText: labelText,
        aspectRatio: aspectRatio,
        imageFile: imageFile,
        onSaved: onSaved,
      ),
    );
  }
}
