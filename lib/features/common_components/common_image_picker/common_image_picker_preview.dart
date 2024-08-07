import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_file_picker/bloc/common_file_picker_bloc.dart';

class CommonImagePickerPreview extends StatelessWidget {
  const CommonImagePickerPreview({super.key, this.aspectRatio = 1});

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100 / aspectRatio,
      height: 100.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: BlocBuilder<CommonFilePickerCubit, CommonFilePickerState>(
        builder: (context, state) {
          if (state.code == CommonFilePickerStateCode.exist) {
            return Image(
              image: FileImage(state.file!),
              fit: BoxFit.cover,
              gaplessPlayback: true,
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context)!.generalPreview),
            );
          }
        }
      ),
    );
  }
}