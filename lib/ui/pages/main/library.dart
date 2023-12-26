import 'package:flutter/material.dart';
import 'package:novelglide/core/file_process.dart';

class LibraryWidget extends StatefulWidget {
  const LibraryWidget({super.key});

  @override
  State<LibraryWidget> createState() => _LibraryWidgetState();
}
class _LibraryWidgetState extends State<LibraryWidget> {
  String path = "";

  @override
  void initState() {
    super.initState();
    FileProcess.get().then((value) {
      setState(() {
        path = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.transparent,
        child: Center(
            child: Text(path)
        )
    );
  }
}