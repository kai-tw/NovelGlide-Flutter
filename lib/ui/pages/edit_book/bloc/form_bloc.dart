import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/core/file_process.dart';
import 'package:novelglide/core/input_verify.dart';

enum EditBookFormBookNameErrorCode { nothing, blank, invalid, exists }

class EditBookFormData {
  String bookName;

  EditBookFormData(this.bookName);

  void save({String? bookName}) {
    this.bookName = bookName ?? this.bookName;
  }

  @override
  String toString() {
    return 'bookName: $bookName';
  }
}

class EditBookFormCubit extends Cubit<EditBookFormState> {
  EditBookFormCubit() : super(const EditBookFormState(EditBookFormBookNameErrorCode.blank));

  EditBookFormData data = EditBookFormData('');

  void bookNameVerify(EditBookFormState state, String? name) async {
    if (name == null || name == '') {
      emit(state.copyWith(bookNameErrorCode: EditBookFormBookNameErrorCode.blank));
      return;
    }
    if (!InputVerify.isFolderNameValid(name)) {
      emit(state.copyWith(bookNameErrorCode: EditBookFormBookNameErrorCode.invalid));
      return;
    }
    if (await FileProcess.isBookExists(name)) {
      emit(state.copyWith(bookNameErrorCode: EditBookFormBookNameErrorCode.exists));
      return;
    }
    emit(state.copyWith(bookNameErrorCode: EditBookFormBookNameErrorCode.nothing));
  }

  void saveData({String? bookName}) {
    data.save(bookName: bookName);
  }

  EditBookFormData getData() {
    return data;
  }

  Future<bool> submitData() async {
    return await FileProcess.createBook(data.bookName);
  }
}

class EditBookFormState extends Equatable {
  final EditBookFormBookNameErrorCode bookNameErrorCode;

  const EditBookFormState(this.bookNameErrorCode);

  EditBookFormState copyWith({EditBookFormBookNameErrorCode? bookNameErrorCode}) {
    return EditBookFormState(bookNameErrorCode!);
  }

  @override
  List<Object?> get props => [bookNameErrorCode];
}
