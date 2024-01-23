import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'bloc/setting_bloc.dart';

class ReaderSettingWidget extends StatelessWidget {
  const ReaderSettingWidget(this.readerSettingBox, {super.key});

  final Box readerSettingBox;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderSettingCubit(readerSettingBox),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.format_size_rounded, size: 12),
                  ),
                  BlocBuilder<ReaderSettingCubit, ReaderSettingState>(
                    builder: (BuildContext context, ReaderSettingState state) {
                      return Expanded(
                        child: Slider(
                          min: state.minFontSize,
                          max: state.maxFontSize,
                          value: state.fontSize,
                          onChanged: (double value) => BlocProvider.of<ReaderSettingCubit>(context).setFontSize(value),
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
            ),
          ],
        ),
      ),
    );
  }
}
