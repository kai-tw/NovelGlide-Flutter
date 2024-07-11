import 'package:flutter/material.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../common_components/common_delete_drag_target.dart';

class HomepageDraggingTargetBar extends StatelessWidget {
  const HomepageDraggingTargetBar({super.key});

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
              onWillAcceptWithDetails: (details) => details.data is BookData || details.data is BookmarkData,
            ),
          ),
        ],
      ),
    );
  }
}
