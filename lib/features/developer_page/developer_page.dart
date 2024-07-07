import 'dart:io';
import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../../data/book_data.dart';
import '../../processor/chapter_processor.dart';
import '../../toolbox/random_utility.dart';
import '../common_components/common_back_button.dart';
import '../settings_page/widgets/setting_page_button.dart';
import 'device_info_panel.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: const Text('Developer Page'),
      ),
      body: Column(
        children: [
          const DeviceInfoPanel(),
          SettingPageButton(
            onPressed: () {
              FirebaseCrashlytics.instance.crash();
            },
            iconData: Icons.error_outline_rounded,
            label: 'Force crash',
          ),
          SettingPageButton(
            onPressed: () => _createFakeBook(context),
            iconData: Icons.code_rounded,
            label: 'Generate a fake book',
          ),
        ],
      ),
    );
  }

  void _createFakeBook(BuildContext context) {
    BookData book;
    do {
      final String randomString = RandomUtility.getRandomString(8);
      final String bookName = 'FakeBook_$randomString';
      book = BookData(name: bookName);
    } while (book.isExists());
    book.create();

    final int chapterCount = Random().nextInt(20);
    for (int i = 0; i < chapterCount; i++) {
      final int ordinalNumber = Random().nextInt(100) + 1;
      final List<String> contentList =
          List.generate(Random().nextInt(100) + 1, (_) => RandomUtility.getRandomString(100));
      File chapterFile = File(ChapterProcessor.getPath(book.name, ordinalNumber));
      chapterFile.writeAsStringSync(contentList.join(Platform.lineTerminator));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fake book ${book.name} created, and $chapterCount chapters created.'),
      ),
    );
  }
}
