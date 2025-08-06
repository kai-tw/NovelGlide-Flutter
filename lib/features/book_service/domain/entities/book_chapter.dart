import 'package:equatable/equatable.dart';

class BookChapter extends Equatable {
  const BookChapter({
    required this.title,
    required this.identifier,
    required this.subChapterList,
  });

  final String title;
  final String identifier;
  final List<BookChapter> subChapterList;

  @override
  List<Object?> get props => <Object?>[
        title,
        identifier,
        subChapterList,
      ];
}
