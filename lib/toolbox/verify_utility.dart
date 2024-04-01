class VerifyUtility {
  static const String folderNamePattern = '\\/?%*:|"<>.';
  static final RegExp folderNameRegex = RegExp(r'[\\/?%*:|"<>.]', unicode: true);
  static bool isFolderNameValid(String name) {
    return !folderNameRegex.hasMatch(name);
  }
}