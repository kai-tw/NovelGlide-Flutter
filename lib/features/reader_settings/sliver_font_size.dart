import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/features/reader/bloc/reader_bloc.dart';

import 'bloc/settings_bloc.dart';

class ReaderSettingsSliverFontSize extends StatelessWidget {
  const ReaderSettingsSliverFontSize({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.format_size_rounded, size: 12),
          ),
          BlocBuilder<ReaderSettingsCubit, ReaderSettingsState>(
            builder: (BuildContext context, ReaderSettingsState state) {
              return Expanded(
                child: Slider(
                  min: state.minFontSize,
                  max: state.maxFontSize,
                  value: state.fontSize,
                  onChanged: (double value) {
                    BlocProvider.of<ReaderSettingsCubit>(context).setFontSize(value);
                    BlocProvider.of<ReaderCubit>(context).applyPreview(fontSize: value);
                  },
                  onChangeEnd: (double value) => BlocProvider.of<ReaderSettingsCubit>(context).saveFontSize(value),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.format_size_rounded, size: 32),
          ),
        ],
      ),
    );
  }

}