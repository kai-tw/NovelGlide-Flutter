import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/chapter_object.dart';

enum AddChapterTitleStateCode { blank, invalid, normal }
enum AddChapterNumberStateCode { blank, invalid, exists, normal }

class AddChapterFormCubit extends Cubit<AddChapterFormState> {
  final String bookName;
  String? title;
  int chapterNumber = -1;
  File? file;

  AddChapterFormCubit(this.bookName) : super(const AddChapterFormState());

  AddChapterNumberStateCode numberVerify(String? numberValue) {
    if (numberValue == null) {
      return AddChapterNumberStateCode.blank;
    }
    int? number = int.tryParse(numberValue);
    if (number == null || number <= 0) {
      return AddChapterNumberStateCode.invalid;
    }
    if (ChapterObject(bookName: bookName, ordinalNumber: number).isExist()) {
      return AddChapterNumberStateCode.exists;
    }
    return AddChapterNumberStateCode.normal;
  }

  Future<bool> submit() async {
    print(chapterNumber);
    return await ChapterObject(bookName: bookName, ordinalNumber: chapterNumber).create(file!, title: title);
  }
}

class AddChapterFormState extends Equatable {
  const AddChapterFormState();

  @override
  List<Object?> get props => [];
}
