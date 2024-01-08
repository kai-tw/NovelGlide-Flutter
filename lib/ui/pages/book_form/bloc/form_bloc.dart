import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/core/input_verify.dart';

enum BookFormType { add, edit, multiEdit }

enum BookFormNameErrorCode { nothing, blank, invalid, exists }

class BookFormData {
  String oldBookName = '';
  String newBookName = '';

  void save({String? oldBookName, String? newBookName}) {
    this.oldBookName = oldBookName ?? this.oldBookName;
    this.newBookName = newBookName ?? this.newBookName;
  }
}

class BookFormCubit extends Cubit<BookFormState> {
  BookFormCubit() : super(const BookFormState(BookFormNameErrorCode.blank));

  BookFormData data = BookFormData();

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

  Future<bool> submitData() async {
    return await FileProcess.createBook(data.newBookName);
  }
}

class BookFormState extends Equatable {
  final BookFormNameErrorCode nameErrorCode;

  const BookFormState(this.nameErrorCode);

  BookFormState copyWith({BookFormNameErrorCode? nameErrorCode}) {
    return BookFormState(nameErrorCode ?? this.nameErrorCode);
  }

  @override
  List<Object?> get props => [nameErrorCode];
}
