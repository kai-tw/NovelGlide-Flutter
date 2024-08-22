import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import 'widgets/reader_title.dart';

class ReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const ReaderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const CommonBackButton(),
      title: const ReaderTitle(),
    );
  }
}