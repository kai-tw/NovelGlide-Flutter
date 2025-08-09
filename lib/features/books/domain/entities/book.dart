import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    required this.identifier,
    required this.title,
    required this.modifiedDate,
    required this.coverIdentifier,
  });

  final String identifier;
  final String title;
  final DateTime modifiedDate;
  final String coverIdentifier;

  @override
  List<Object?> get props =>
      <Object?>[identifier, title, modifiedDate, coverIdentifier];
}
