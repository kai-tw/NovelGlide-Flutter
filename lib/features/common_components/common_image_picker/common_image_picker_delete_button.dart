import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared_bloc/common_file_picker_bloc.dart';

class CommonImagePickerDeleteButton extends StatelessWidget {
  const CommonImagePickerDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    return TextButton.icon(
      onPressed: () => cubit.removeFile(),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
      ),
      icon: const Icon(Icons.delete_outline_outlined),
      label: Text(AppLocalizations.of(context)!.remove_image),
    );
  }
}