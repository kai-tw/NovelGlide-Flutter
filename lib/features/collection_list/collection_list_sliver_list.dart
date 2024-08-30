import 'package:flutter/material.dart';

class CollectionListSliverList extends StatelessWidget {
  const CollectionListSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: Text('CollectionListSliverList'),
      ),
    );
  }
}