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

        if (isRequired && state.code == CommonFilePickerStateCode.blank) {
          decoration = inputDecoration!.copyWith(errorText: appLocalizations.fieldBlank);
        } else if (state.code == CommonFilePickerStateCode.illegalType) {
          decoration = inputDecoration!.copyWith(errorText: appLocalizations.fieldFileNotAccepted);
        } else {
          decoration = inputDecoration!.copyWith(errorText: null);
        }

        return FormField(
          validator: (_) {
            return isRequired && cubit.validator() ? '' : null;
          },
          builder: (_) => InputDecorator(
            decoration: decoration,
            child: child,
          ),
          onSaved: (_) {
            if (onSaved != null) {
              onSaved!(cubit.file);
            }
          },
        );
      },
    );
  }
}
