part of '../../../book_service.dart';

class BookAddState extends Equatable {
  const BookAddState({this.pathSet = const <String>{}});

  final Set<String> pathSet;

  bool get isValid =>
      pathSet.isNotEmpty &&
      !pathSet.any((String path) =>
          BookService.repository.exists(path) ||
          MimeResolver.lookupAll(File(path)) != 'application/epub+zip');

  @override
  List<Object?> get props => <Object?>[pathSet];
}
