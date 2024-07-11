import 'package:flutter/material.dart';

import '../../../data/chapter_data.dart';
import '../../common_components/common_delete_drag_target.dart';

class TocDraggingTargetBar extends StatelessWidget {
  const TocDraggingTargetBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.0,
      height: 64.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CommonDeleteDragTarget(
              onWillAcceptWithDetails: (details) => details.data is ChapterData,
            ),
          ),
        ],
      ),
    );
  }
}