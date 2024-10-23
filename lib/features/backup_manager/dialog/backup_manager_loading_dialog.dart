import 'package:flutter/material.dart';

import '../../common_components/common_loading.dart';

/// A dialog that displays a loading indicator for backup management operations.
class BackupManagerLoadingDialog extends StatelessWidget {
  final String? title;

  const BackupManagerLoadingDialog({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 200.0,
        height: 100.0,
        child: CommonLoading(
          title: title,
        ),
      ),
    );
  }
}
