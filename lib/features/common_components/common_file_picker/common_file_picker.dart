import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/common_file_picker_bloc.dart';
import 'common_file_picker_content.dart';
import 'common_file_picker_form_field.dart';
import 'common_file_picker_type.dart';

class CommonFilePicker extends StatelessWidget {
  final CommonFilePickerType? type;
  final bool isRequired;
  final List<String>? allowedExtensions;
  final InputDecoration? inputDecoration;
  final void Function(File?)? onSaved;
  final String? semanticLabel;

  const CommonFilePicker({
    super.key,
    this.type,
    this.isRequired = true,
    this.allowedExtensions,
    this.inputDecoration,
    this.onSaved,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? AppLocalizations.of(context)!.accessibilityFilePicker,
      child: BlocProvider(
        create: (_) => CommonFilePickerCubit(),
        child: CommonFilePickerFormField(
          inputDecoration: inputDecoration,
          onSaved: onSaved,
          isRequired: isRequired,
          child: CommonFilePickerContent(
            type: type,
            allowedExtensions: allowedExtensions,
          ),
        ),
      ),
    );
  }
}
