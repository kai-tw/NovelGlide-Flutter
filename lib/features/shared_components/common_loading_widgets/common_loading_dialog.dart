import 'package:flutter/material.dart';

import 'common_loading_widget.dart';

/// A dialog that displays a loading indicator for backup management operations.
class CommonLoadingDialog extends CommonLoadingWidget {
  const CommonLoadingDialog({super.key, super.title, super.progress});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 200.0,
        height: 100.0,
        child: super.build(context),
      ),
    );
  }
}
