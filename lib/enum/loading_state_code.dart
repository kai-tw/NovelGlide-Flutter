enum LoadingStateCode {
  initial,
  loading,
  backgroundLoading,
  loaded;
  // loaded,
  // error;

  bool get isLoading => this == LoadingStateCode.loading;
  bool get isBackgroundLoading => this == LoadingStateCode.backgroundLoading;
  bool get isLoaded => this == LoadingStateCode.loaded;
  // bool get isError => this == LoadingStateCode.error;
}
