import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/ui/components/emoticon_collection.dart';

class LibraryWidget extends StatefulWidget {
  const LibraryWidget({super.key});

  @override
  State<LibraryWidget> createState() => _LibraryWidgetState();
}

class _LibraryWidgetState extends State<LibraryWidget> {
  Widget mainWidget = const SizedBox();
  String noBookLocalization = '';

  @override
  void initState() {
    super.initState();
    FileProcess.getLibraryBookList().then(renderBookList);
  }

  @override
  Widget build(BuildContext context) {
    noBookLocalization = AppLocalizations.of(context)!.no_book;
    return Hero(
        tag: 'Library List Hero',
        child: Padding(padding: const EdgeInsets.all(16), child: mainWidget));
  }

  void renderBookList(List<Directory> bookList) {
    List<Widget> bookWidgetList = [];
    setState(() {
      if (bookList.isNotEmpty) {
        mainWidget = Column(children: bookWidgetList);
        for (Directory item in bookList) {
          bookWidgetList.add(ListTile(title: Text(basename(item.path))));
        }
      } else {
        mainWidget = Center(
          child: Center(
              child: Text(
                  '${EmoticonCollection.getRandomShock()}\n$noBookLocalization',
                  textAlign: TextAlign.center)),
        );
      }
    });
  }
}
