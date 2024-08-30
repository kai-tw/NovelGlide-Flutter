import 'package:flutter/material.dart';

class CollectionListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollectionListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.collections_bookmark_outlined),
      title: const Text('Collection'),
    );
  }
}