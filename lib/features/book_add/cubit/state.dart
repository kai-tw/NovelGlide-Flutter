part of 'cubit.dart';

class BookAddState extends Equatable {
  final File? file;

  bool get isEmpty => file == null;

  int get fileLength => file?.lengthSync() ?? 0;

  String? get filePath => file?.path;

  bool get fileExists => isEmpty || BookRepository.exists(filePath!);

  bool get isValid => !isEmpty && !fileExists;

  @override
  List<Object?> get props => [file];

  const BookAddState({this.file});
}
