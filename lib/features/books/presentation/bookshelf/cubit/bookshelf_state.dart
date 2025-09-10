import 'package:equatable/equatable.dart';

class BookshelfState extends Equatable {
  const BookshelfState({
    this.tabIndex = 0,
    this.isTabRunning = false,
    this.enableTab = true,
  });

  final int tabIndex;
  final bool isTabRunning;
  final bool enableTab;

  @override
  List<Object?> get props => <Object?>[
        tabIndex,
        isTabRunning,
        enableTab,
      ];

  BookshelfState copyWith({
    int? tabIndex,
    bool? isTabRunning,
    bool? enableTab,
  }) {
    return BookshelfState(
      tabIndex: tabIndex ?? this.tabIndex,
      isTabRunning: isTabRunning ?? this.isTabRunning,
      enableTab: enableTab ?? this.enableTab,
    );
  }
}
