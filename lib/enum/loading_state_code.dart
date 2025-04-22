enum LoadingStateCode {
  initial,
  loading,
  loaded;

  bool get isLoading => this == LoadingStateCode.loading;
  bool get isLoaded => this == LoadingStateCode.loaded;
}
