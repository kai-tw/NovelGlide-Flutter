import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../reader_setting/bottom_sheet.dart';

class ReaderNavBar extends StatelessWidget {
  const ReaderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded)),
          IconButton(onPressed: () => _settingOnPressed(context), icon: const Icon(Icons.settings_rounded)),
        ],
      ),
    );
  }

  void _settingOnPressed(BuildContext context) {
    final Box readerSettingBox = Hive.box(name: 'reader_setting', maxSizeMiB: 1);
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 1.0,
      showDragHandle: true,
      builder: (BuildContext context) {
        return ReaderSettingBottomSheet(readerSettingBox);
      },
    ).then((_) {
      readerSettingBox.close();
    });
  }
}
