import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/common_file_picker_bloc.dart';
import 'common_file_picker_type.dart';

class CommonFilePickerDeleteButton extends StatelessWidget {
  const CommonFilePickerDeleteButton({super.key, this.iconData, this.labelText, this.type});

  final CommonFilePickerType? type;
  final IconData? iconData;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<CommonFilePickerType, IconData?> typeIconMap = {
      CommonFilePickerType.custom: iconData,
    };
    final Map<CommonFilePickerType, String?> typeLabelMap = {
      CommonFilePickerType.image: appLocalizations.remove_image,
      CommonFilePickerType.custom: labelText,
    };

    return TextButton.icon(
      onPressed: () => cubit.removeFile(),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
      ),
      icon: Icon(typeIconMap[type] ?? Icons.delete_outline_outlined),
      label: Text(typeLabelMap[type] ?? AppLocalizations.of(context)!.delete),
    );
  }
}