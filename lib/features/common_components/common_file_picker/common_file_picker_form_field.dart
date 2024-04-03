import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/common_file_picker_bloc.dart';

class CommonFilePickerFormField extends StatelessWidget {
  final Widget child;
  final bool isRequired;
  final InputDecoration? inputDecoration;
  final void Function(File?)? onSaved;

  const CommonFilePickerFormField({
    super.key,
    required this.child,
    this.isRequired = true,
    this.inputDecoration,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<CommonFilePickerCubit, CommonFilePickerState>(
      builder: (context, state) {
        InputDecoration decoration = inputDecoration ?? const InputDecoration();

        if (inputDecoration != null && isRequired && state.code == CommonFilePickerStateCode.blank) {
          decoration = inputDecoration!.copyWith(errorText: appLocalizations.fieldBlank);
        }

        return FormField(
          validator: (_) => _validator(cubit.file),
          builder: (_) => InputDecorator(
            decoration: decoration,
            child: child,
          ),
        );
      },
    );
  }

  String? _validator(File? file) {
    if (onSaved != null) {
      onSaved!(file);
    }
    return isRequired && file == null ? '' : null;
  }
}
