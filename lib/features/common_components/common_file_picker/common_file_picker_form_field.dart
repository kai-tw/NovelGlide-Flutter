import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_form_decoration.dart';
import 'bloc/common_file_picker_bloc.dart';

class CommonFilePickerFormField extends StatelessWidget {
  const CommonFilePickerFormField({super.key, required this.child, this.labelText, this.onSaved});

  final String? labelText;
  final Widget child;
  final void Function(File?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final CommonFilePickerCubit cubit = BlocProvider.of<CommonFilePickerCubit>(context);
    return FormField(
      validator: (_) => _validator(cubit.file),
      builder: (_) => InputDecorator(
        decoration: CommonFormDecoration.inputDecoration(
          labelText,
          padding: const EdgeInsets.fromLTRB(24.0, 24.0, 0, 24.0),
        ),
        child: child,
      ),
    );
  }

  String? _validator(File? file) {
    if (onSaved != null) {
      onSaved!(file);
    }
    return null;
  }
}
