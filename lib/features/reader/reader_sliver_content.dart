import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_loading.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';

class ReaderSliverContent extends StatelessWidget {
  const ReaderSliverContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        switch (state.code) {
          case ReaderStateCode.loaded:
            List<String> contentLines = state.contentLines;
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  double fontSize = state.readerSettings.fontSize;
                  double lineHeight = state.readerSettings.lineHeight;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: fontSize * lineHeight),
                    child: Text(
                      contentLines[index],
                      style: TextStyle(fontSize: fontSize, height: lineHeight),
                    ),
                  );
                },
                childCount: contentLines.length,
              ),
            );

          default:
            return const CommonSliverLoading();
        }
      },
    );
  }
}
