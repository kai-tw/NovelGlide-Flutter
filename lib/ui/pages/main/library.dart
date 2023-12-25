import 'package:flutter/material.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
        shadowColor: Colors.transparent,
        child: Center(
            child: Text(
                "Library"
            )
        )
    );
  }
}