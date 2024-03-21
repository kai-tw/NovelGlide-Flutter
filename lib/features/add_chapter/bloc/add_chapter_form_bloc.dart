import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AddChapterNameStateCode { blank, invalid, exists }
enum AddChapterNumberStateCode { blank, invalid, exists }

class AddChapterFormCubit extends Cubit<AddChapterFormState> {
  AddChapterFormCubit() : super(const AddChapterFormState());

  AddChapterNameStateCode nameVerify(String? name) {
    return AddChapterNameStateCode.blank;
  }

  AddChapterNumberStateCode numberVerify(String? numberValue) {
    if (numberValue == null) {
      return AddChapterNumberStateCode.blank;
    }
    int number = int.parse(numberValue);
    return AddChapterNumberStateCode.blank;
  }
}

class AddChapterFormState extends Equatable {
  const AddChapterFormState();

  @override
  List<Object?> get props => [];
}
