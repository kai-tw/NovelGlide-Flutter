import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_file_picker/bloc/common_file_picker_bloc.dart';
import '../common_file_picker/common_file_picker_delete_button.dart';
import '../common_file_picker/common_file_picker_select_button.dart';
import '../common_file_picker/common_file_picker_type.dart';

class CommonImagePickerButtonList extends StatelessWidget {
  const CommonImagePickerButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonFilePickerCubit, CommonFilePickerState>(
      builder: (context, state) {
        List<Widget> list = [
          const CommonFilePickerSelectButton(type: CommonFilePickerType.image),
        ];

        if (state.code == CommonFilePickerStateCode.exist) {
          list.add(const CommonFilePickerDeleteButton(type: CommonFilePickerType.image));
        }

        return Column(children: list);
      },
    );
  }
}
