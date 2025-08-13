import 'package:equatable/equatable.dart';

class BookPickFileData extends Equatable {
  const BookPickFileData({
    required this.absolutePath,
    required this.baseName,
    required this.fileSize,
    required this.existsInLibrary,
    required this.isTypeValid,
  });

  final String absolutePath;
  final String baseName;
  final String fileSize;
  final bool existsInLibrary;
  final bool isTypeValid;

  bool get isValid => !existsInLibrary && isTypeValid;

  @override
  List<Object?> get props => <Object?>[
        absolutePath,
        baseName,
        fileSize,
        existsInLibrary,
        isTypeValid,
      ];
}
