import 'package:flutter_bloc/flutter_bloc.dart';

import 'bookshelf_state.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  BookshelfCubit() : super(const BookshelfState());

  void switchTab(int index) {
    emit(state.copyWith(
      tabIndex: index,
    ));
  }

  void setTabRunning(bool isRunning) {
    emit(state.copyWith(
      isTabRunning: isRunning,
    ));
  }
}
