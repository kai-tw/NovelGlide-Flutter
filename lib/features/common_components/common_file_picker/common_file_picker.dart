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
  final InputDecoration? inputDecoration;
  final void Function(File?)? onSaved;

  const CommonFilePicker({
    super.key,
    this.type,
    this.allowedExtensions,
    this.inputDecoration,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommonFilePickerCubit(),
      child: CommonFilePickerFormField(
        inputDecoration: inputDecoration,
        onSaved: onSaved,
        child: CommonFilePickerContent(
          type: type,
          allowedExtensions: allowedExtensions,
        ),
      ),
    );
  }
}
