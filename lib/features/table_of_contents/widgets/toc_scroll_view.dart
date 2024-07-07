import 'package:flutter/material.dart';

class TocScrollView extends StatelessWidget {
  final List<Widget> slivers;

  const TocScrollView({super.key, required this.slivers});

  @override
  Widget build(BuildContext context) {
    List<Widget> sliverList = List.from(slivers);

    /// Prevent the content from being covered by the floating action button.
    sliverList.add(const SliverPadding(padding: EdgeInsets.only(bottom: 80.0)));

    return Scrollbar(
      child: CustomScrollView(
        slivers: sliverList,
      ),
    );
  }
}