part of 'book_add_cubit.dart';

class BookAddState extends Equatable {
  const BookAddState({this.file});

  final File? file;

  bool get isEmpty => file == null;

  int get fileLength => file?.lengthSync() ?? 0;

  String? get filePath => file?.path;

  bool get fileExists => isEmpty || BookRepository.exists(filePath!);

  bool get isFileTypeValid =>
      isEmpty ? false : MimeResolver.lookupAll(file!) == 'application/epub+zip';

  bool get isValid => !isEmpty && !fileExists && isFileTypeValid;

  @override
  List<Object?> get props => <Object?>[file];
}
