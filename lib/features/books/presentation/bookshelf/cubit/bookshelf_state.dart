import 'package:equatable/equatable.dart';

class BookshelfState extends Equatable {
  const BookshelfState({
    this.tabIndex = 0,
  });

  final int tabIndex;

  @override
  List<Object?> get props => <Object?>[
        tabIndex,
      ];
}
