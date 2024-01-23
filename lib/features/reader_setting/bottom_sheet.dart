import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'scaffold.dart';

class ReaderSettingBottomSheet extends StatelessWidget {
  const ReaderSettingBottomSheet(this.readerSettingBox, {super.key});

  final Box readerSettingBox;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.25,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return ReaderSettingWidget(readerSettingBox);
      },
    );
  }

}