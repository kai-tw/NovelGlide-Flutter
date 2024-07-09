import 'package:flutter/material.dart';

import 'homepage_book_delete_drag_target.dart';

class HomepageDraggingBar extends StatelessWidget {
  const HomepageDraggingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: HomepageBookDeleteDragTarget(),
        ),
      ],
    );
  }
}
