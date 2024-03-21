import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared_bloc/common_file_picker_bloc.dart';

class CommonImagePickerSelectButton extends StatelessWidget {
  const CommonImagePickerSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    return TextButton.icon(
      onPressed: () => cubit.pickImage(),
      icon: const Icon(Icons.image_rounded),
      label: Text(AppLocalizations.of(context)!.select_image),
    );
  }
}