import 'dart:io';

import 'package:flutter/material.dart';

class CommonImagePickerContent extends StatelessWidget {
  const CommonImagePickerContent({required this.labelText, required this.buttonList, this.aspectRatio = 1, this.imageFile, super.key});

  final String labelText;
  final List<Widget> buttonList;
  final double aspectRatio;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
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
          Container(
            width: 100 / aspectRatio,
            height: 100.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: _getPreviewImage(context),
          ),
          const Padding(padding: EdgeInsets.only(right: 16.0)),
          Expanded(
            child: Column(children: buttonList),
          ),
        ],
      ),
    );
  }

  Widget _getPreviewImage(BuildContext context) {
    if (imageFile != null && imageFile!.existsSync()) {
      return Image(
        image: FileImage(imageFile!),
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );
    } else {
      return Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      );
    }
  }
}