import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';

import '../../../data/zip_encoding.dart';
import '../../../processor/book_processor.dart';

class BookImporterCubit extends Cubit<BookImporterState> {
  File? _importFile;
  ZipEncoding? _zipEncoding;

  BookImporterCubit() : super(const BookImporterState());

  Future<bool> submit() async {
    String? mimeType = lookupMimeType(_importFile!.path);
    switch (mimeType) {
      case 'application/zip':
        return await BookProcessor.importFromZip(_importFile!, zipEncoding: _zipEncoding);
      case 'application/epub+zip':
        return await BookProcessor.importFromEpub(_importFile!);
    }
    return false;
  }

  void setImportFile(File? importFile) {
    _importFile = importFile;
  }

  void setZipEncoding(ZipEncoding? zipEncoding) {
    _zipEncoding = zipEncoding;
  }
}

class BookImporterState extends Equatable {
  @override
  List<Object?> get props => [];

  const BookImporterState();
}
