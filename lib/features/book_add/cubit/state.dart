part of 'cubit.dart';

class BookAddState extends Equatable {
  final File? file;

  bool get isEmpty => file == null;

  int get fileLength => file?.lengthSync() ?? 0;

  String? get filePath => file?.path;

  bool get fileExists => isEmpty || BookRepository.exists(filePath!);

  bool get isExtensionValid => filePath == null
      ? false
      : BookAddCubit.allowedExtensions
          .any((extension) => filePath!.endsWith(extension));

  bool get isValid => !isEmpty && !fileExists && isExtensionValid;

  @override
  List<Object?> get props => [file];

  const BookAddState({this.file});
}
