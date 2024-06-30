import 'package:flutter/material.dart';

import '../reader/settings/auto_save_switch.dart';
import '../reader/settings/font_size_slider.dart';
import '../reader/settings/line_height_slider.dart';
import '../reader/settings/reset_button.dart';
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
        );
      },
    );
  }
}
