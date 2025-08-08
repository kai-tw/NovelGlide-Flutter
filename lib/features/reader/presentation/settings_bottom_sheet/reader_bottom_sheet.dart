import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/preference_service/data/model/reader_preference_data.dart';
import '../../../../enum/common_button_state_code.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../settings_page/settings_service.dart';
import '../../domain/entities/reader_page_num_type.dart';
import '../reader_page/cubit/reader_cubit.dart';

part 'settings_reset_button.dart';
part 'widgets/auto_save_switch.dart';
part 'widgets/font_size_slider.dart';
part 'widgets/line_height_slider.dart';
part 'widgets/page_num_selector.dart';
part 'widgets/settings_slider.dart';
part 'widgets/smooth_scroll_switch.dart';

class ReaderBottomSheet extends StatelessWidget {
  const ReaderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: 0.8,
      expand: false,
      snap: true,
      snapSizes: const <double>[0.25, 0.5, 0.8],
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: const Column(
            children: <Widget>[
              SettingsCard(
                margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  children: <Widget>[
                    _FontSizeSlider(),
                    _LineHeightSlider(),
                  ],
                ),
              ),
              SettingsCard(
                margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  children: <Widget>[
                    _AutoSaveSwitch(),
                    _SmoothScrollSwitch(),
                  ],
                ),
              ),
              SettingsCard(
                margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  children: <Widget>[
                    _PageNumSelector(),
                  ],
                ),
              ),
              SettingsCard(
                margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: _SettingsResetButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
