enum LoadingStateCode {
  initial,
  loading,
  loaded;

  const LoadingStateCode();

  bool get isLoaded => this == LoadingStateCode.loaded;
}
