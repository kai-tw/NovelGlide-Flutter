import 'package:flutter/material.dart';

class BookImporterOverwriteSwitch extends StatelessWidget {
  const BookImporterOverwriteSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: false,
      onChanged: (value) => {},
    );
  }
}