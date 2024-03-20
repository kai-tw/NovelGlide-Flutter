import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/common_image_picker_bloc.dart';
import 'common_image_picker_delete_button.dart';
import 'common_image_picker_select_button.dart';

class CommonImagePickerButtonList extends StatelessWidget {
  const CommonImagePickerButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonImagePickerCubit, CommonImagePickerState>(
      builder: (context, state) {
        List<Widget> list = [const CommonImagePickerSelectButton()];

        if (state.imageFile != null) {
          list.add(const CommonImagePickerDeleteButton());
        }

        return Column(children: list);
      },
    );
  }
}
