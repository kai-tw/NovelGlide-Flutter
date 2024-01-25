import 'package:flutter/material.dart';

class ReaderSliverAppBar extends StatelessWidget {
  const ReaderSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
