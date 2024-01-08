import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/core/input_verify.dart';

enum BookFormNameErrorCode { nothing, blank, invalid, exists }

class BookFormData {
  String bookName;

  BookFormData(this.bookName);

  void save({String? bookName}) {
    this.bookName = bookName ?? this.bookName;
  }

  @override
  String toString() {
    return 'bookName: $bookName';
  }
}

class BookFormCubit extends Cubit<BookFormState> {
  BookFormCubit() : super(const BookFormState(BookFormNameErrorCode.blank));

  BookFormData data = BookFormData('');

  void bookNameVerify(BookFormState state, String? name) async {
    if (name == null || name == '') {
      emit(state.copyWith(bookNameErrorCode: BookFormNameErrorCode.blank));
      return;
    }
    if (!InputVerify.isFolderNameValid(name)) {
      emit(state.copyWith(bookNameErrorCode: BookFormNameErrorCode.invalid));
      return;
    }
    if (await FileProcess.isBookExists(name)) {
      emit(state.copyWith(bookNameErrorCode: BookFormNameErrorCode.exists));
      return;
    }
    emit(state.copyWith(bookNameErrorCode: BookFormNameErrorCode.nothing));
  }

  void saveData({String? bookName}) {
    data.save(bookName: bookName);
  }

  BookFormData getData() {
    return data;
  }

  Future<bool> submitData() async {
    return await FileProcess.createBook(data.bookName);
  }
}

class BookFormState extends Equatable {
  final BookFormNameErrorCode bookNameErrorCode;

  const BookFormState(this.bookNameErrorCode);

  BookFormState copyWith({BookFormNameErrorCode? bookNameErrorCode}) {
    return BookFormState(bookNameErrorCode!);
  }

  @override
  List<Object?> get props => [bookNameErrorCode];
}
