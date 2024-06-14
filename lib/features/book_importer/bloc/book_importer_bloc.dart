import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';

import '../../../data/book_data.dart';
import '../../../toolbox/book_processor.dart';

class BookImporterCubit extends Cubit<BookImporterState> {
  BookImporterCubit(this.bookData) : super(const BookImporterState());

  BookData bookData;
  File? importFile;

  Future<bool> submit() async {
    String? mimeType = lookupMimeType(importFile!.path);
    switch (mimeType) {
      case 'application/zip':
        return await BookProcessor.importFromArchive(bookData.name, importFile!);
    }
    return false;
  }
}

class BookImporterState extends Equatable {
  const BookImporterState();

  @override
  List<Object?> get props => [];
}
