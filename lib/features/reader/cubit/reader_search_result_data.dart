part of 'reader_cubit.dart';

class ReaderSearchResultData extends Equatable {
  final String cfi;
  final String excerpt;

  @override
  List<Object?> get props => [cfi, excerpt];

  const ReaderSearchResultData({
    required this.cfi,
    required this.excerpt,
  });
}
