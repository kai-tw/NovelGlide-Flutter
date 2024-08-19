import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../data/file_path.dart';
import '../../../toolbox/file_helper.dart';

class AddBookCubit extends Cubit<AddBookState> {AddBookCubit() : super(const AddBookState());

  void pickFile() async {
    FilePickerResult? f = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
    );

    emit(AddBookState(file: f != null ? File(f.files.single.path!) : null));
  }

  Future<void> submit() async {
    File file = File(join(FilePath.instance.libraryRoot, state.fileName));

    if (file.existsSync()) {
      throw AddBookDuplicateFileException();
    }

    state.file!.copySync(file.path);
  }

  void removeFile() {
    emit(const AddBookState());
  }
}

class AddBookState extends Equatable {
  final File? file;

  String get fileName => file != null ? basename(file!.path) : '-';
  String get fileSize => file != null ? FileHelper.getFileSizeString(file!.lengthSync()) : '-';

  @override
  List<Object?> get props => [file, fileName, fileSize];

  const AddBookState({this.file});
}

class AddBookDuplicateFileException implements Exception {}
