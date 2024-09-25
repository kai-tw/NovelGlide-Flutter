import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/reader_settings_data.dart';
import '../bloc/reader_settings_bloc.dart';

class ReaderSettingsGestureSwitcher extends StatelessWidget {
  const ReaderSettingsGestureSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderSettingsCubit cubit = BlocProvider.of<ReaderSettingsCubit>(context);
    return BlocBuilder<ReaderSettingsCubit, ReaderSettingsData>(
      buildWhen: (previous, current) => previous.gestureDetection != current.gestureDetection,
      builder: (context, state) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text("Gesture Detection"),
          value: state.gestureDetection,
          onChanged: (value) {
            cubit.setState(gestureDetection: value);
            cubit.save();
          },
        );
      },
    );
  }
}