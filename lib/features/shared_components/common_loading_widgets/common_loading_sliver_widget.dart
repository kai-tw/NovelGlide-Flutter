import 'package:flutter/material.dart';

import 'common_loading_widget.dart';

/// The sliver version of [CommonLoadingWidget].
class CommonSliverLoading extends CommonLoadingWidget {
  const CommonSliverLoading({
    super.key,
    super.title,
    super.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: super.build(context),
    );
  }
}

/// A dialog that displays a loading indicator for backup management operations.
class CommonLoadingDialog extends StatelessWidget {
  const CommonLoadingDialog({super.key, this.title, this.progress});

  final String? title;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 200.0,
        height: 100.0,
        child: CommonLoadingWidget(
          title: title,
          progress: progress,
        ),
      ),
    );
  }
}
