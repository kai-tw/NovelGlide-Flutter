import 'package:flutter/material.dart';

class TOCSliverAppBar extends StatelessWidget {
  const TOCSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded),
        ),
      ],
    );
  }

}