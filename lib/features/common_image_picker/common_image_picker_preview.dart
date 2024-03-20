import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/common_image_picker_bloc.dart';

class CommonImagePickerPreview extends StatelessWidget {
  const CommonImagePickerPreview({super.key, this.aspectRatio = 1});

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100 / aspectRatio,
      height: 100.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: BlocBuilder<CommonImagePickerCubit, CommonImagePickerState>(
        builder: (context, state) {
          if (state.imageFile != null && state.imageFile!.existsSync()) {
            return Image(
              image: FileImage(state.imageFile!),
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
      ),
    );
  }
}