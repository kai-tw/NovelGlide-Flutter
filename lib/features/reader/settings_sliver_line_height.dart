import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_bloc.dart';

class ReaderSettingsSliverLineHeight extends StatelessWidget {
  const ReaderSettingsSliverLineHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 32,
            child: const Icon(Icons.density_small_rounded),
          ),
          BlocBuilder<ReaderCubit, ReaderState>(
            builder: (BuildContext context, ReaderState state) {
              return Expanded(
                child: Slider(
                  min: ReaderState.minLineHeight,
                  max: ReaderState.maxLineHeight,
                  value: state.lineHeight,
                  onChanged: (double value) => BlocProvider.of<ReaderCubit>(context).set(lineHeight: value),
                  onChangeEnd: (double value) => BlocProvider.of<ReaderCubit>(context).save(lineHeight: value),
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 32,
            child: const Icon(Icons.density_large_rounded),
          ),
        ],
      ),
    );
  }
}
