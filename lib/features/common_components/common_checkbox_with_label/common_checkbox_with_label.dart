import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/common_checkbox_with_label_bloc.dart';

class CommonCheckboxWithLabel extends StatelessWidget {
  final String text;
  final bool isChecked;
  final Function(bool?) onChanged;

  const CommonCheckboxWithLabel({
    super.key,
    required this.text,
    required this.onChanged,
    this.isChecked = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommonCheckboxWithLabelCubit(),
      child: Row(
        children: [
          BlocBuilder<CommonCheckboxWithLabelCubit, CommonCheckboxWithLabelState>(
            builder: (context, state) {
              final CommonCheckboxWithLabelCubit cubit = BlocProvider.of<CommonCheckboxWithLabelCubit>(context);
              return Checkbox(
                value: state.isChecked,
                onChanged: (value) {
                  cubit.onClick(value);
                  onChanged(value);
                },
              );
            },
          ),
          Text(text),
        ],
      ),
    );
  }
}
