import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_form_decoration.dart';
import 'bloc/common_file_picker_bloc.dart';

class CommonFilePickerFormField extends StatelessWidget {
  const CommonFilePickerFormField({super.key, required this.child, this.labelText, this.isRequired = true, this.onSaved});

  final String? labelText;
  final Widget child;
  final bool isRequired;
  final void Function(File?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<CommonFilePickerCubit, CommonFilePickerState>(
      builder: (context, state) {
        String? errorText;

        if (isRequired && state.code == CommonFilePickerStateCode.blank) {
          errorText = appLocalizations.fieldBlank;
        }

        return FormField(
          validator: (_) => _validator(cubit.file),
          builder: (_) => InputDecorator(
            decoration: CommonFormDecoration.inputDecoration(
              labelText,
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 0, 24.0),
              errorText: errorText,
            ),
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
