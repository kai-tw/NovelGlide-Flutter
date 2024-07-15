import 'package:flutter/material.dart';

import 'common_processing.dart';

class CommonProcessingDialog extends StatelessWidget {
  const CommonProcessingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, bottom: 24.0),
        child: CommonProcessing(),
      ),
    );
  }
}