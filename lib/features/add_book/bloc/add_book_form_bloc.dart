import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../toolbox/book_processor.dart';
import '../../../toolbox/verify_utility.dart';

enum AddBookFormNameStateCode { valid, blank, invalid, exists }

class AddBookFormCubit extends Cubit<AddBookFormState> {
  AddBookFormCubit() : super(const AddBookFormState());

  BookData data = BookData();
  File? importArchiveFile;

  AddBookFormNameStateCode nameVerify(String? name) {
    if (name == null || name == '') {
      return AddBookFormNameStateCode.blank;
    }

    if (!VerifyUtility.isFolderNameValid(name)) {
      return AddBookFormNameStateCode.invalid;
    }

    final BookData inputBookObject = BookData.fromName(name);
    if (inputBookObject.isExists()) {
      return AddBookFormNameStateCode.exists;
    }

    // Name verification passed.
    data.name = name;
    return AddBookFormNameStateCode.valid;
  }

  Future<bool> submit() async {
    bool isSuccess = await data.create();

    if (importArchiveFile != null) {
      isSuccess = isSuccess && await BookProcessor.importFromArchive(data.name, importArchiveFile!);
    }

    return isSuccess;
  }
}

class AddBookFormState extends Equatable {
  const AddBookFormState();

  @override
  List<Object?> get props => [];
}
