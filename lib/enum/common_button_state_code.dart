enum CommonButtonStateCode {
  idle,
  loading,
  success,
  error,
  disabled;

  bool get isIdle => this == CommonButtonStateCode.idle;
  bool get isLoading => this == CommonButtonStateCode.loading;
  bool get isSuccess => this == CommonButtonStateCode.success;
  bool get isError => this == CommonButtonStateCode.error;
  bool get isDisabled => this == CommonButtonStateCode.disabled;
}
