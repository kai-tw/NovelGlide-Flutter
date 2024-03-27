import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AddChapterNameStateCode { blank, invalid, normal }
enum AddChapterNumberStateCode { blank, invalid, normal }

class AddChapterFormCubit extends Cubit<AddChapterFormState> {
  AddChapterFormCubit() : super(const AddChapterFormState());

  AddChapterNameStateCode nameVerify(String? name) {
    if (name == null || name == '') {
      return AddChapterNameStateCode.blank;
    }

    return AddChapterNameStateCode.normal;
  }

  AddChapterNumberStateCode numberVerify(String? numberValue) {
    if (numberValue == null) {
      return AddChapterNumberStateCode.blank;
    }

    int? number = int.tryParse(numberValue);
    if (number == null || number <= 0) {
      return AddChapterNumberStateCode.invalid;
    }

    return AddChapterNumberStateCode.normal;
  }

  Future<bool> submit() async {
    return false;
  }
}

class AddChapterFormState extends Equatable {
  const AddChapterFormState();

  @override
  List<Object?> get props => [];
}
