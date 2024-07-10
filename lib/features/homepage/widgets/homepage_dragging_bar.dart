import 'package:flutter/material.dart';

import 'homepage_book_delete_drag_target.dart';

class HomepageDraggingBar extends StatelessWidget {
  const HomepageDraggingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.0,
      height: 64.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: HomepageBookDeleteDragTarget(),
          ),
        ],
      ),
    );
  }
}
