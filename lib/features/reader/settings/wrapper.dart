import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import 'sliver_font_size.dart';
import 'sliver_line_height.dart';
import 'sliver_reset_button.dart';

class ReaderSettingsBottomSheet extends StatelessWidget {
  const ReaderSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: 0.5,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        BlocProvider.of<ReaderCubit>(context).initialize();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            controller: scrollController,
            slivers: const [
              ReaderSettingsSliverFontSize(),
              SliverPadding(padding: EdgeInsets.only(bottom: 8.0)),
              ReaderSettingsSliverLineHeight(),
              SliverPadding(padding: EdgeInsets.only(bottom: 8.0)),
              ReaderSettingsSliverResetButton(),
            ],
          ),
        );
      },
    );
  }
}
