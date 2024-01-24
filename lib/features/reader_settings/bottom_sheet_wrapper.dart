import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/settings_bloc.dart';
import 'sliver_font_size.dart';

class ReaderSettingsBottomSheet extends StatelessWidget {
  const ReaderSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderSettingsCubit(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 0.5,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          BlocProvider.of<ReaderSettingsCubit>(context).loadSettings();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              controller: scrollController,
              slivers: const [
                ReaderSettingsSliverFontSize(),
              ],
            ),
          );
        },
      ),
    );
  }
}
