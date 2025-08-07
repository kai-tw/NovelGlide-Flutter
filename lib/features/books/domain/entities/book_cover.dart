import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class BookCover extends Equatable {
  const BookCover({
    required this.identifier,
    this.width,
    this.height,
    this.url,
    this.bytes,
  });

  final String identifier;
  final double? width;
  final double? height;
  final String? url;
  final Uint8List? bytes;

  bool get hasSize => width != null && height != null;

  @override
  List<Object?> get props => <Object?>[
        identifier,
        width,
        height,
        url,
        bytes,
      ];
}
