import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../preference_keys/preference_keys.dart';

/// Represents the settings for a reader, including font size, line height, and other preferences.
class ReaderSettingsData extends Equatable {
  final double fontSize;
  static const defaultFontSize = 16.0;
  static const minFontSize = 12.0;
  static const maxFontSize = 32.0;

  final double lineHeight;
  static const defaultLineHeight = 1.5;
  static const minLineHeight = 1.0;
  static const maxLineHeight = 3.0;

  final bool isAutoSaving;
  static const defaultIsAutoSaving = false;

  final bool isSmoothScroll;
  static const defaultIsSmoothScroll = false;

  final bool isUsingThemeStyle;
  static const defaultIsUsingThemeStyle = false;

  final ReaderSettingsPageNumType pageNumType;
  static const defaultPageNumType = ReaderSettingsPageNumType.number;

  @override
  List<Object?> get props => [
        fontSize,
        lineHeight,
        isAutoSaving,
        isSmoothScroll,
        isUsingThemeStyle,
        pageNumType,
      ];

  const ReaderSettingsData({
    this.fontSize = defaultFontSize,
    this.lineHeight = defaultLineHeight,
    this.isAutoSaving = defaultIsAutoSaving,
    this.isSmoothScroll = defaultIsSmoothScroll,
    this.isUsingThemeStyle = defaultIsUsingThemeStyle,
    this.pageNumType = defaultPageNumType,
  });

  /// Loads the reader settings from shared preferences.
  static Future<ReaderSettingsData> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return ReaderSettingsData(
      fontSize:
          prefs.getDouble(PreferenceKeys.reader.fontSize) ?? defaultFontSize,
      lineHeight: prefs.getDouble(PreferenceKeys.reader.lineHeight) ??
          defaultLineHeight,
      isAutoSaving: prefs.getBool(PreferenceKeys.reader.isAutoSaving) ??
          defaultIsAutoSaving,
      isSmoothScroll: prefs.getBool(PreferenceKeys.reader.isSmoothScroll) ??
          defaultIsSmoothScroll,
      isUsingThemeStyle:
          prefs.getBool(PreferenceKeys.reader.isUsingThemeStyle) ??
              defaultIsUsingThemeStyle,
      pageNumType: ReaderSettingsPageNumType.values[
          prefs.getInt(PreferenceKeys.reader.pageNumType) ??
              defaultPageNumType.index],
    );
  }

  /// Creates a copy of the current settings with optional new values.
  ReaderSettingsData copyWith({
    double? fontSize,
    double? lineHeight,
    bool? isAutoSaving,
    bool? isSmoothScroll,
    bool? isUsingThemeStyle,
    ReaderSettingsPageNumType? pageNumType,
  }) {
    return ReaderSettingsData(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight:
          (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
      isAutoSaving: isAutoSaving ?? this.isAutoSaving,
      isSmoothScroll: isSmoothScroll ?? this.isSmoothScroll,
      isUsingThemeStyle: isUsingThemeStyle ?? this.isUsingThemeStyle,
      pageNumType: pageNumType ?? this.pageNumType,
    );
  }

  /// Saves the current settings to shared preferences.
  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(PreferenceKeys.reader.fontSize, fontSize);
    prefs.setDouble(PreferenceKeys.reader.lineHeight, lineHeight);
    prefs.setBool(PreferenceKeys.reader.isAutoSaving, isAutoSaving);
    prefs.setBool(PreferenceKeys.reader.isSmoothScroll, isSmoothScroll);
    prefs.setBool(PreferenceKeys.reader.isUsingThemeStyle, isUsingThemeStyle);
    prefs.setInt(PreferenceKeys.reader.pageNumType, pageNumType.index);
  }
}

enum ReaderSettingsPageNumType { hidden, number, percentage, progressBar }
