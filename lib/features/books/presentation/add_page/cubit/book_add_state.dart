import 'package:equatable/equatable.dart';

import '../../../domain/entities/book_pick_file_data.dart';

class BookAddState extends Equatable {
  const BookAddState({
    this.fileSet = const <BookPickFileData>{},
  });

  final Set<BookPickFileData> fileSet;

  bool get isValid =>
      fileSet.isNotEmpty &&
      !fileSet.any((BookPickFileData state) => !state.isValid);

  @override
  List<Object?> get props => <Object?>[
        fileSet,
      ];
}
