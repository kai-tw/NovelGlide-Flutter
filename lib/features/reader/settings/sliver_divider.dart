import 'package:flutter/material.dart';

class ReaderSettingsDivider extends StatelessWidget {
  const ReaderSettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Divider(
        height: 60.0,
        thickness: 1.0,
      ),
    );
  }
}
