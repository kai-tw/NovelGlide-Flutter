import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_settings_bloc.dart';
import 'widgets/reader_settings_auto_save_switch.dart';
import 'widgets/reader_settings_font_size_slider.dart';
import 'widgets/reader_settings_line_height_slider.dart';
import 'widgets/reader_settings_reset_button.dart';
import 'widgets/reader_settings_section_container.dart';

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
        return SingleChildScrollView(
          controller: scrollController,
          child: BlocProvider(
            create: (context) => ReaderSettingsCubit(),
            child: const Column(
              children: [
                ReaderSettingsSectionContainer(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: ReaderSettingsFontSizeSlider(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: ReaderSettingsLineHeightSlider(),
                      ),
                    ],
                  ),
                ),
                ReaderSettingsSectionContainer(
                  child: ReaderSettingsAutoSaveSwitch(),
                ),
                ReaderSettingsSectionContainer(
                  child: ReaderSettingsResetButton(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
