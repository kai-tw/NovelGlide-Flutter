import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsSliverFontSize extends StatelessWidget {
  const ReaderSettingsSliverFontSize({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 32,
            child: Icon(
              Icons.format_size_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: ReaderState.minFontSize,
            ),
          ),
          BlocBuilder<ReaderCubit, ReaderState>(
            builder: (BuildContext context, ReaderState state) {
              return Expanded(
                child: Slider(
                  min: ReaderState.minFontSize,
                  max: ReaderState.maxFontSize,
                  value: state.fontSize,
                  onChanged: (double value) => BlocProvider.of<ReaderCubit>(context).setSettings(fontSize: value),
                  onChangeEnd: (double value) => BlocProvider.of<ReaderCubit>(context).saveSettings(fontSize: value),
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 32,
            child: Icon(
              Icons.format_size_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: ReaderState.maxFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
