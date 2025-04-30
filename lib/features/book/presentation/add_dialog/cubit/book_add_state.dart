part of 'book_add_cubit.dart';

class BookAddState extends Equatable {
  const BookAddState({this.fileList = const <File>[]});

  final List<File> fileList;

  bool get isEmpty => fileList.isEmpty;

  int get totalFileSize {
    return fileList.fold<int>(0, (int previous, File file) {
      return previous + file.lengthSync();
    });
  }

  List<File> get duplicatedFiles {
    return fileList.where((File file) {
      return BookRepository.exists(file.path);
    }).toList();
  }

  List<File> get invalidFiles {
    return fileList.where((File file) {
      return MimeResolver.lookupAll(file) != 'application/epub+zip';
    }).toList();
  }

  bool get isValid =>
      fileList.isNotEmpty && duplicatedFiles.isEmpty && invalidFiles.isEmpty;

  @override
  List<Object?> get props => <Object?>[fileList];
}
