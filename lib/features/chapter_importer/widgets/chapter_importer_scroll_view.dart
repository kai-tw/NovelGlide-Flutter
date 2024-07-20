import 'package:flutter/material.dart';

class ChapterImporterScrollView extends StatelessWidget {
  final Widget child;

  const ChapterImporterScrollView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 360),
          child: child,
        ),
      ),
    );
  }
}