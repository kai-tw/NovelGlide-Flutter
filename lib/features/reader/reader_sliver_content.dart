import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_cubit.dart';
import 'bloc/reader_state.dart';
import 'widgets/reader_content_single_line.dart';

class ReaderSliverContent extends StatelessWidget {
  const ReaderSliverContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.contentLines != current.contentLines,
      builder: (BuildContext context, ReaderState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ReaderContentSingleLine(content: state.contentLines[index]);
            },
            childCount: state.contentLines.length,
          ),
        );
      },
    );
  }
}
