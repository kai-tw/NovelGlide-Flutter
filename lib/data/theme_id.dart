enum ThemeId {
  defaultTheme,
}

extension ThemeIdExtension on ThemeId {
  static ThemeId? getFromString(String? str) {
    try {
      return ThemeId.values.firstWhere((e) => e.toString() == str);
    } catch (e) {
      return null;
    }
  }
}