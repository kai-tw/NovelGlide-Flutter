class AccountEditNormalFormCubit {
  static final AccountEditNormalFormCubit instance = AccountEditNormalFormCubit._init();
  String? displayName;
  String? phoneNumber;

  factory AccountEditNormalFormCubit() {
    return instance;
  }

  AccountEditNormalFormCubit._init();
}