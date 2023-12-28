import 'package:flutter/material.dart';
import 'package:novelglide/core/file_process.dart';

class LibraryWidget extends StatefulWidget {
  const LibraryWidget({super.key});

  @override
  State<LibraryWidget> createState() => _LibraryWidgetState();
}

class _LibraryWidgetState extends State<LibraryWidget> {
  String supportPath = "";
  String documentPath = "";
  String cachePath = "";
  String tempPath = "";

  @override
  void initState() {
    super.initState();
    FileProcess.supportFolder.then((value) {
      setState(() {
        supportPath = value;
      });
    });
    FileProcess.documentFolder.then((value) {
      setState(() {
        documentPath = value;
      });
    });
    FileProcess.cacheFolder.then((value) {
      setState(() {
        cachePath = value;
      });
    });
    FileProcess.tempFolder.then((value) {
      setState(() {
        tempPath = value;
      });
    });
    FileProcess.createIfNotExists(FileProcess.typeFolder, "/NovelGlide");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text(supportPath),
              Text(documentPath),
              Text(cachePath),
              Text(tempPath)
      ]))));
  }
}
