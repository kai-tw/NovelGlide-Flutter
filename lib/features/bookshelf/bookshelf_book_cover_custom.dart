import 'dart:io';

import 'package:flutter/material.dart';

class BookshelfBookCoverCustom extends StatelessWidget {
  const BookshelfBookCoverCustom({super.key, required this.coverPath});

  final String coverPath;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: FileImage(File(coverPath)),
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }
}