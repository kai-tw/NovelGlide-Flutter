import 'package:equatable/equatable.dart';

class BookshelfState extends Equatable {
  const BookshelfState({
    this.tabIndex = 0,
    this.isTabRunning = false,
  });

  final int tabIndex;
  final bool isTabRunning;

  @override
  List<Object?> get props => <Object?>[
        tabIndex,
        isTabRunning,
      ];

  BookshelfState copyWith({
    int? tabIndex,
    bool? isTabRunning,
  }) {
    return BookshelfState(
      tabIndex: tabIndex ?? this.tabIndex,
      isTabRunning: isTabRunning ?? this.isTabRunning,
    );
  }
}
