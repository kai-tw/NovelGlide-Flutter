import 'package:flutter/material.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/window_class.dart';
import '../../common_components/common_delete_drag_target.dart';

class HomepageDraggingTargetBar extends StatelessWidget {
  const HomepageDraggingTargetBar({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    BoxConstraints constraints;

    switch (windowClass) {
      case WindowClass.compact:
        constraints = BoxConstraints(maxWidth: WindowClass.compact.maxWidth);
        break;
      default:
        constraints = const BoxConstraints(maxWidth: 360.0);
    }

    return Container(
      height: 64.0,
      constraints: constraints,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
            offset: const Offset(0.0, 4.0),
            blurRadius: 16.0,
          ),
        ],
      ),
      child: CommonDeleteDragTarget(
        onWillAcceptWithDetails: (details) => details.data is BookData || details.data is BookmarkData,
      ),
    );
  }
}
