import 'package:flutter/material.dart';

import 'widgets/reader_settings_auto_save_switch.dart';
import 'widgets/reader_settings_font_size_slider.dart';
import 'widgets/reader_settings_gesture_switcher.dart';
import 'widgets/reader_settings_line_height_slider.dart';
import 'widgets/reader_settings_reset_button.dart';

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
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Column(
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
              Container(
                margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Column(
                  children: [
                    ReaderSettingsAutoSaveSwitch(),
                    ReaderSettingsGestureSwitcher(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const ReaderSettingsResetButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}
