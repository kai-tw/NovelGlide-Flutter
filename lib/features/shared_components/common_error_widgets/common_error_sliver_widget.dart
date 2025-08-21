import 'package:flutter/material.dart';

import 'common_error_widget.dart';

class CommonErrorSliverWidget extends CommonErrorWidget {
  const CommonErrorSliverWidget({
    super.key,
    super.icon,
    super.content,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: super.build(context),
    );
  }
}
