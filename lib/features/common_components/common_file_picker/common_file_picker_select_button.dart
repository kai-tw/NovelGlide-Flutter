import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/common_file_picker_bloc.dart';
import 'common_file_picker_type.dart';

class CommonFilePickerSelectButton extends StatelessWidget {
  const CommonFilePickerSelectButton({super.key, this.iconData, this.labelText, this.type, this.allowedExtensions});

  final CommonFilePickerType? type;
  final IconData? iconData;
  final String? labelText;
  final List<String>? allowedExtensions;

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<CommonFilePickerType, IconData?> typeIconMap = {
      CommonFilePickerType.image: Icons.image_rounded,
      CommonFilePickerType.custom: iconData,
    };
    final Map<CommonFilePickerType, String?> typeLabelMap = {
      CommonFilePickerType.image: appLocalizations.fieldSelectImage,
      CommonFilePickerType.custom: labelText,
    };
    final Map<CommonFilePickerType, void Function()?> typeOnPressedMap = {
      CommonFilePickerType.image: cubit.pickImage,
      CommonFilePickerType.custom: () => cubit.pickFile(type: type, allowedExtensions: allowedExtensions),
    };

    return TextButton.icon(
      onPressed: typeOnPressedMap[type] ?? () => cubit.pickFile(type: type, allowedExtensions: allowedExtensions),
      icon: Icon(typeIconMap[type] ?? Icons.file_upload_rounded),
      label: Text(typeLabelMap[type] ?? appLocalizations.generalSelect),
    );
  }
}