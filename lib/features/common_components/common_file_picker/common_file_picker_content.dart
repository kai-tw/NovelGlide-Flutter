import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/common_file_picker_bloc.dart';
import 'common_file_picker_delete_button.dart';
import 'common_file_picker_select_button.dart';
import 'common_file_picker_type.dart';

class CommonFilePickerContent extends StatelessWidget {
  const CommonFilePickerContent({super.key, this.type, this.allowedExtensions});

  final CommonFilePickerType? type;
  final List<String>? allowedExtensions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonFilePickerCubit, CommonFilePickerState>(
      builder: (context, state) {
        final List<Widget> children = [CommonFilePickerSelectButton(
          type: type,
          allowedExtensions: allowedExtensions,
        )];

        if (state.code == CommonFilePickerStateCode.exist) {
          children.add(const CommonFilePickerDeleteButton());
        }

        return Row(
          children: children,
        );
      },
    );
  }
}
