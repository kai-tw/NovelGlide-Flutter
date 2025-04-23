enum LoadingStateCode {
  initial,
  loading,
  backgroundLoading,
  loaded;

  bool get isLoading => this == LoadingStateCode.loading;
  bool get isBackgroundLoading => this == LoadingStateCode.backgroundLoading;
  bool get isLoaded => this == LoadingStateCode.loaded;
}
