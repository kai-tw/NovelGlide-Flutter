import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';

class ReaderContentSingleLine extends StatelessWidget {
  final String content;

  const ReaderContentSingleLine({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.readerSettings.fontSize != current.readerSettings.fontSize ||
          previous.readerSettings.lineHeight != current.readerSettings.lineHeight,
      builder: (BuildContext context, ReaderState fontState) {
        double fontSize = fontState.readerSettings.fontSize;
        double lineHeight = fontState.readerSettings.lineHeight;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: fontSize * lineHeight),
          child: Text(
            content,
            style: TextStyle(fontSize: fontSize, height: lineHeight),
          ),
        );
      },
    );
  }
}