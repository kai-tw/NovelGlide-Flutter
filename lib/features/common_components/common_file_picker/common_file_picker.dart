import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/common_file_picker_bloc.dart';
import 'common_file_picker_content.dart';
import 'common_file_picker_form_field.dart';
import 'common_file_picker_type.dart';

class CommonFilePicker extends StatelessWidget {
  final CommonFilePickerType? type;
  final List<String>? allowedExtensions;
  final String? labelText;
  final Widget? suffixIcon;
  final void Function(File?)? onSaved;

  const CommonFilePicker({
    super.key,
    this.labelText,
    this.onSaved,
    this.type,
    this.allowedExtensions,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommonFilePickerCubit(),
      child: CommonFilePickerFormField(
        labelText: labelText,
        onSaved: onSaved,
        suffixIcon: suffixIcon,
        child: CommonFilePickerContent(
          type: type,
          allowedExtensions: allowedExtensions,
        ),
      ),
    );
  }
}
