import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_settings.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsLineHeightSlider extends StatelessWidget {
  const ReaderSettingsLineHeightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            width: 32,
            child: Icon(
              Icons.density_small_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          BlocBuilder<ReaderCubit, ReaderState>(
            builder: (BuildContext context, ReaderState state) {
              return Expanded(
                child: Slider(
                  min: ReaderSettings.minLineHeight,
                  max: ReaderSettings.maxLineHeight,
                  value: state.readerSettings.lineHeight,
                  onChanged: (double value) => BlocProvider.of<ReaderCubit>(context).setSettings(lineHeight: value),
                  onChangeEnd: (double value) => BlocProvider.of<ReaderCubit>(context).saveSettings(lineHeight: value),
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 8.0),
            width: 32,
            child: Icon(
              Icons.density_large_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
