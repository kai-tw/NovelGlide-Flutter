part of 'reader_cubit.dart';

enum ReaderLoadingStateCode {
  initial,
  bookLoading,
  rendering,
  loaded;

  bool get isInitial => this == ReaderLoadingStateCode.initial;

  bool get isLoading =>
      this == ReaderLoadingStateCode.bookLoading ||
      this == ReaderLoadingStateCode.rendering;

  bool get isLoaded => this == ReaderLoadingStateCode.loaded;
}
