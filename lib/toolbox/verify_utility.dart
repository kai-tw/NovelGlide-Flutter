class VerifyUtility {
  /// Patterns
  static const String folderNameDenyPattern = r'\\/?%*:|"<>.';
  static const String passwordAllowPattern = r"[a-zA-Z0-9!@#\$%^&*()-_=+[\]{}|;:'" r'",.<>/?]+';

  /// Regex
  static final RegExp folderNameDenyRegex = RegExp(folderNameDenyPattern, unicode: true);
  static final RegExp passwordAllowRegex = RegExp(passwordAllowPattern);

  /// Functions
  static bool isFolderNameValid(String name) {
    return !folderNameDenyRegex.hasMatch(name);
  }

  VerifyUtility._();
}
