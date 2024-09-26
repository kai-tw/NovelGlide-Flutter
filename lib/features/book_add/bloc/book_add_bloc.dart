import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../toolbox/file_path.dart';
import '../../../toolbox/file_helper.dart';

class BookAddCubit extends Cubit<BookAddState> {BookAddCubit() : super(const BookAddState());

  void pickFile() async {
    FilePickerResult? f = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
    );

    emit(BookAddState(file: f != null ? File(f.files.single.path!) : null));
  }

  Future<void> submit() async {
    File file = File(join(await FilePath.libraryRoot, state.fileName));

    if (file.existsSync()) {
      throw AddBookDuplicateFileException();
    }

    state.file!.copySync(file.path);
  }

  void removeFile() {
    emit(const BookAddState());
  }
}

class BookAddState extends Equatable {
  final File? file;

  String? get fileName => file != null ? basename(file!.path) : null;
  String? get fileSize => file != null ? FileHelper.getFileSizeString(file!.lengthSync()) : null;

  @override
  List<Object?> get props => [file, fileName, fileSize];

  const BookAddState({this.file});
}

class AddBookDuplicateFileException implements Exception {}
