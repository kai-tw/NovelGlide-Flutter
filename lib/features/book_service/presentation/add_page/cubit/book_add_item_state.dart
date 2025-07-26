part of '../../../book_service.dart';

class BookAddItemState extends Equatable {
  const BookAddItemState({
    required this.absolutePath,
    required this.isExistsInLibrary,
    required this.isMimeValid,
  });

  final String absolutePath;
  final bool isExistsInLibrary;
  final bool isMimeValid;

  File get _file => File(absolutePath);

  String get lengthString => _file.lengthString();

  String get baseName => basename(absolutePath);

  bool get isValid => !isExistsInLibrary && isMimeValid;

  @override
  List<Object?> get props => <Object?>[
        absolutePath,
        isExistsInLibrary,
        isMimeValid,
      ];
}
