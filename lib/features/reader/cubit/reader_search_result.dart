part of 'reader_cubit.dart';

class ReaderSearchResult extends Equatable {
  final String cfi;
  final String excerpt;

  @override
  List<Object?> get props => [cfi, excerpt];

  const ReaderSearchResult({
    required this.cfi,
    required this.excerpt,
  });
}
