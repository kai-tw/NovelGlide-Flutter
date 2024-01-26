import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_settings.dart';
import '../bloc/reader_state.dart';

class ReaderSettingsSliverFontSize extends StatelessWidget {
  const ReaderSettingsSliverFontSize({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderCubit readerCubit = BlocProvider.of<ReaderCubit>(context);
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 32,
            child: Icon(
              Icons.format_size_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: ReaderSettings.minFontSize,
            ),
          ),
          BlocBuilder<ReaderCubit, ReaderState>(
            builder: (BuildContext context, ReaderState state) {
              return Expanded(
                child: Slider(
                  min: ReaderSettings.minFontSize,
                  max: ReaderSettings.maxFontSize,
                  value: state.readerSettings.fontSize,
                  onChanged: (double value) => readerCubit.setSettings(fontSize: value),
                  onChangeEnd: (double value) => readerCubit.saveSettings(fontSize: value),
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
              size: ReaderSettings.maxFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
