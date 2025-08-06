import 'package:equatable/equatable.dart';

import 'book_add_item_state.dart';

class BookAddState extends Equatable {
  const BookAddState({
    this.itemState = const <BookAddItemState>{},
  });

  final Set<BookAddItemState> itemState;

  bool get isValid =>
      itemState.isNotEmpty &&
      !itemState.any((BookAddItemState state) => !state.isValid);

  @override
  List<Object?> get props => <Object?>[
        itemState,
      ];
}
