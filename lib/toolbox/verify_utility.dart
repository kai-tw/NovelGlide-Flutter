class VerifyUtility {
  /// Patterns
  static const String folderNameDenyPattern = r'\\/?%*:|"<>.';
  static const String emailDenyPattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  static const String passwordAllowPattern = r"[a-zA-Z0-9!@#\$%^&*()-_=+[\]{}|;:'" r'",.<>/?]+';

  /// Regex
  static final RegExp folderNameDenyRegex = RegExp(folderNameDenyPattern, unicode: true);
  static final RegExp emailDenyRegex = RegExp(emailDenyPattern);
  static final RegExp passwordAllowRegex = RegExp(passwordAllowPattern);

  /// Functions
  static bool isFolderNameValid(String name) {
    return !folderNameDenyRegex.hasMatch(name);
  }

  static bool isEmailValid(String email) {
    return !emailDenyRegex.hasMatch(email);
  }
}
