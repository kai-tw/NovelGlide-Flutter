import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reader/bloc/reader_cubit.dart';
import 'bloc/reader_settings_bloc.dart';
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
          child: BlocProvider(
            create: (context) => ReaderSettingsCubit(BlocProvider.of<ReaderCubit>(context)),
            child: const Column(
              children: [
                _CustomContainer(
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
                _CustomContainer(
                  child: Column(
                    children: [
                      ReaderSettingsAutoSaveSwitch(),
                      ReaderSettingsGestureSwitcher(),
                    ],
                  ),
                ),
                _CustomContainer(
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

class _CustomContainer extends StatelessWidget {
  const _CustomContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}
