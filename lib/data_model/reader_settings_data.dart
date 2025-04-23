import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../preference_keys/preference_keys.dart';

/// Represents the settings for a reader, including font size, line height, and other preferences.
class ReaderSettingsData extends Equatable {
  const ReaderSettingsData({
    this.fontSize = defaultFontSize,
    this.lineHeight = defaultLineHeight,
    this.isAutoSaving = defaultIsAutoSaving,
    this.isSmoothScroll = defaultIsSmoothScroll,
    this.pageNumType = defaultPageNumType,
  });

  final double fontSize;
  static const double defaultFontSize = 16.0;
  static const double minFontSize = 12.0;
  static const double maxFontSize = 32.0;

  final double lineHeight;
  static const double defaultLineHeight = 1.5;
  static const double minLineHeight = 1.0;
  static const double maxLineHeight = 3.0;

  final bool isAutoSaving;
  static const bool defaultIsAutoSaving = false;

  final bool isSmoothScroll;
  static const bool defaultIsSmoothScroll = false;

  final ReaderSettingsPageNumType pageNumType;
  static const ReaderSettingsPageNumType defaultPageNumType =
      ReaderSettingsPageNumType.number;

  @override
  List<Object?> get props => <Object?>[
        fontSize,
        lineHeight,
        isAutoSaving,
        isSmoothScroll,
        pageNumType,
      ];

  /// Loads the reader settings from shared preferences.
  static Future<ReaderSettingsData> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double fontSize, lineHeight;
    bool isAutoSaving, isSmoothScroll;
    int pageNumType;

    // Load font size
    try {
      fontSize =
          prefs.getDouble(PreferenceKeys.reader.fontSize) ?? defaultFontSize;
    } catch (_) {
      fontSize = defaultFontSize;
    }

    // Load line height
    try {
      lineHeight = prefs.getDouble(PreferenceKeys.reader.lineHeight) ??
          defaultLineHeight;
    } catch (_) {
      lineHeight = defaultLineHeight;
    }

    // Load auto-saving preference
    try {
      isAutoSaving = prefs.getBool(PreferenceKeys.reader.isAutoSaving) ??
          defaultIsAutoSaving;
    } catch (_) {
      isAutoSaving = defaultIsAutoSaving;
    }

    // Load smooth scroll preference
    try {
      isSmoothScroll = prefs.getBool(PreferenceKeys.reader.isSmoothScroll) ??
          defaultIsSmoothScroll;
    } catch (_) {
      isSmoothScroll = defaultIsSmoothScroll;
    }

    // Load page number type
    try {
      pageNumType = prefs.getInt(PreferenceKeys.reader.pageNumType) ??
          defaultPageNumType.index;
    } catch (_) {
      pageNumType = defaultPageNumType.index;
    }

    return ReaderSettingsData(
      fontSize: fontSize.clamp(minFontSize, maxFontSize),
      lineHeight: lineHeight.clamp(minLineHeight, maxLineHeight),
      isAutoSaving: isAutoSaving,
      isSmoothScroll: isSmoothScroll,
      pageNumType: ReaderSettingsPageNumType.values[pageNumType],
    );
  }

  /// Creates a copy of the current settings with optional new values.
  ReaderSettingsData copyWith({
    double? fontSize,
    double? lineHeight,
    bool? isAutoSaving,
    bool? isSmoothScroll,
    ReaderSettingsPageNumType? pageNumType,
  }) {
    return ReaderSettingsData(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight:
          (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
      isAutoSaving: isAutoSaving ?? this.isAutoSaving,
      isSmoothScroll: isSmoothScroll ?? this.isSmoothScroll,
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
    prefs.setInt(PreferenceKeys.reader.pageNumType, pageNumType.index);
  }
}

enum ReaderSettingsPageNumType { hidden, number, percentage, progressBar }
