import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:novel_glide/core/utils/file_extension.dart';
import 'package:path/path.dart';

class BookAddItemState extends Equatable {
  const BookAddItemState({
    required this.absolutePath,
    required this.existsInLibrary,
    required this.isTypeValid,
  });

  final String absolutePath;
  final bool existsInLibrary;
  final bool isTypeValid;

  File get _file => File(absolutePath);

  String get lengthString => _file.lengthString();

  String get baseName => basename(absolutePath);

  bool get isValid => !existsInLibrary && isTypeValid;

  @override
  List<Object?> get props => <Object?>[
        absolutePath,
        existsInLibrary,
        isTypeValid,
      ];
}
