enum LoadingStateCode {
  initial,
  loading,
  backgroundLoading,
  loaded,
  error;

  bool get isInitial => this == LoadingStateCode.initial;
  bool get isLoading => this == LoadingStateCode.loading;
  bool get isBackgroundLoading => this == LoadingStateCode.backgroundLoading;
  bool get isLoaded => this == LoadingStateCode.loaded;
  bool get isError => this == LoadingStateCode.error;
}
