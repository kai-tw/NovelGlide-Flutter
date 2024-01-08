import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/core/input_verify.dart';

enum BookFormType { add, edit, multiEdit }

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
  BookFormCubit() : super(const BookFormState(BookFormType.add, BookFormNameErrorCode.blank));

  BookFormData data = BookFormData('');

  void bookNameVerify(BookFormState state, String? name) async {
    if (name == null || name == '') {
      emit(state.copyWith(nameErrorCode: BookFormNameErrorCode.blank));
      return;
    }
    if (!InputVerify.isFolderNameValid(name)) {
      emit(state.copyWith(nameErrorCode: BookFormNameErrorCode.invalid));
      return;
    }
    if (await FileProcess.isBookExists(name)) {
      emit(state.copyWith(nameErrorCode: BookFormNameErrorCode.exists));
      return;
    }
    emit(state.copyWith(nameErrorCode: BookFormNameErrorCode.nothing));
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
  final BookFormType type;
  final BookFormNameErrorCode nameErrorCode;

  const BookFormState(this.type, this.nameErrorCode);

  BookFormState copyWith({
    BookFormType? type,
    BookFormNameErrorCode? nameErrorCode,
  }) {
    return BookFormState(
      type ?? this.type,
      nameErrorCode ?? this.nameErrorCode,
    );
  }

  @override
  List<Object?> get props => [nameErrorCode];
}
