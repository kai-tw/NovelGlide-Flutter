import 'package:equatable/equatable.dart';

class ReaderSearchResultData extends Equatable {
  const ReaderSearchResultData({
    required this.cfi,
    required this.excerpt,
  });

  final String cfi;
  final String excerpt;

  @override
  List<Object?> get props => <Object?>[cfi, excerpt];
}
