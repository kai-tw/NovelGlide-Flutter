class VerifyUtility {
  static final RegExp folderNameRegex = RegExp(r'[\\/?%*:|"<>.]', unicode: true);
  static bool isFolderNameValid(String name) {
    return !folderNameRegex.hasMatch(name);
  }
}