import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/reader_navigation_state_code.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';
import 'default/reader_nav_add_button.dart';
import 'default/reader_nav_next_button.dart';
import 'default/reader_nav_previous_button.dart';
import 'default/reader_nav_settings_button.dart';
import 'default/reader_nav_tts_button.dart';
import 'tts/reader_nav_tts_close_button.dart';

class ReaderNavigationRail extends StatelessWidget {
  const ReaderNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64.0,
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (context, state) {
          switch (state.navigationStateCode) {
            case ReaderNavigationStateCode.ttsState:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ReaderNavTtsCloseButton(),
                ],
              );

            default:
              return const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ReaderNavSettingsButton(),
                  ReaderNavTtsButton(),
                  ReaderNavAddButton(),
                  ReaderNavPreviousButton(),
                  ReaderNavNextButton(),
                ],
              );
          }
        },
      ),
    );
  }
}
