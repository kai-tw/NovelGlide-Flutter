import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import 'auto_save_switch.dart';
import 'font_size_slider.dart';
import 'line_height_slider.dart';
import 'reset_button.dart';

class ReaderSettingsBottomSheet extends StatelessWidget {
  const ReaderSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: 0.8,
      expand: false,
      snap: true,
      snapSizes: const [0.25, 0.5, 0.8],
      builder: (BuildContext context, ScrollController scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomScrollView(
            controller: scrollController,
            slivers: const [
              ReaderSettingsFontSizeSlider(),
              SliverPadding(padding: EdgeInsets.only(bottom: 8.0)),
              ReaderSettingsLineHeightSlider(),
              SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
              ReaderSettingsAutoSaveSwitch(),
              SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
              ReaderSettingsResetButton(),
            ],
          ),
        );
      },
    );
  }
}
