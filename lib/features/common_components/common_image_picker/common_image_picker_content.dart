import 'dart:io';

import 'package:flutter/material.dart';

import '../common_image_picker/common_image_picker_button_list.dart';
import '../common_image_picker/common_image_picker_preview.dart';

class CommonImagePickerContent extends StatelessWidget {
  const CommonImagePickerContent(
      {this.aspectRatio = 1, this.imageFile, super.key});

  final double aspectRatio;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImagePickerPreview(aspectRatio: aspectRatio),
        const Padding(padding: EdgeInsets.only(right: 16.0)),
        const Expanded(
          child: CommonImagePickerButtonList(),
        ),
      ],
    );
  }
}
