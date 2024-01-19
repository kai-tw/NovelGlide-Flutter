import 'package:flutter/material.dart';

import 'sliver_app_bar.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ReaderSliverAppBar(),
        ],
      ),
    );
  }
}