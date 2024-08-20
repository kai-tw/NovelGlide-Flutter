class CSSHelper {
  static String removeComments(String css) {
    return css.replaceAll(RegExp(r'/\*.*?\*/', multiLine: true), '');
  }
}