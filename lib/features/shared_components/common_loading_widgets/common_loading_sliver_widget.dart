import 'package:flutter/material.dart';

import 'common_loading_widget.dart';

/// The sliver version of [CommonLoadingWidget].
class CommonLoadingSliverWidget extends CommonLoadingWidget {
  const CommonLoadingSliverWidget({
    super.key,
    super.title,
    super.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: super.build(context),
    );
  }
}
