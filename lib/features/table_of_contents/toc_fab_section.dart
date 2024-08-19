import 'package:flutter/material.dart';

import '../../data/window_class.dart';
import 'widgets/toc_continue_reading_button.dart';

class TocFabSection extends StatelessWidget {
  const TocFabSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    double maxWidth = MediaQuery.of(context).size.width - kFloatingActionButtonMargin;

    if (windowClass != WindowClass.compact) {
      maxWidth *= 0.618;
    }

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TocContinueReadingButton(),
            ),
          ),
        ],
      ),
    );
  }
}
