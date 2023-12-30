class InputVerify {
  static bool folderName(String name) {
    RegExp regex = RegExp(r'^[\p{L}\p{N}_-]+$', unicode: true);
    return regex.hasMatch(name);
  }
}