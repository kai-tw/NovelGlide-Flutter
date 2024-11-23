import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preference_keys.dart';

/// Represents the settings for a reader, including font size, line height, and other preferences.
class ReaderSettingsData extends Equatable {
  final double fontSize;
  static const double defaultFontSize = 16.0;
  static const double minFontSize = 12.0;
  static const double maxFontSize = 32.0;

  final double lineHeight;
  static const double defaultLineHeight = 1.5;
  static const double minLineHeight = 1.0;
  static const double maxLineHeight = 3.0;

  final bool autoSave;
  final bool gestureDetection;
  final bool isSmoothScroll;

  final ReaderSettingsPageNumType pageNumType;

  static final ReaderPref _readerKey = PreferenceKeys.reader;

  @override
  List<Object?> get props => [
        fontSize,
        lineHeight,
        autoSave,
        gestureDetection,
        isSmoothScroll,
        pageNumType,
      ];

  const ReaderSettingsData({
    this.fontSize = defaultFontSize,
    this.lineHeight = defaultLineHeight,
    this.autoSave = false,
    this.gestureDetection = true,
    this.isSmoothScroll = false,
    this.pageNumType = ReaderSettingsPageNumType.number,
  });

  /// Loads the reader settings from shared preferences.
  static Future<ReaderSettingsData> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return ReaderSettingsData(
      fontSize: prefs.getDouble(_readerKey.fontSize) ?? defaultFontSize,
      lineHeight: prefs.getDouble(_readerKey.lineHeight) ?? defaultLineHeight,
      autoSave: prefs.getBool(_readerKey.autoSave) ?? false,
      gestureDetection: prefs.getBool(_readerKey.gestureDetection) ?? true,
      isSmoothScroll: prefs.getBool(_readerKey.isSmoothScroll) ?? false,
      pageNumType: ReaderSettingsPageNumType.fromString(
          prefs.getString(_readerKey.pageNumType)),
    );
  }

  /// Creates a copy of the current settings with optional new values.
  ReaderSettingsData copyWith({
    double? fontSize,
    double? lineHeight,
    bool? autoSave,
    bool? gestureDetection,
    bool? isSmoothScroll,
    ReaderSettingsPageNumType? pageNumType,
  }) {
    return ReaderSettingsData(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight:
          (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
      autoSave: autoSave ?? this.autoSave,
      gestureDetection: gestureDetection ?? this.gestureDetection,
      isSmoothScroll: isSmoothScroll ?? this.isSmoothScroll,
      pageNumType: pageNumType ?? this.pageNumType,
    );
  }

  /// Saves the current settings to shared preferences.
  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(_readerKey.fontSize, fontSize);
    prefs.setDouble(_readerKey.lineHeight, lineHeight);
    prefs.setBool(_readerKey.autoSave, autoSave);
    prefs.setBool(_readerKey.gestureDetection, gestureDetection);
    prefs.setBool(_readerKey.isSmoothScroll, isSmoothScroll);
    prefs.setString(_readerKey.pageNumType, pageNumType.toString());
  }
}

enum ReaderSettingsPageNumType {
  hidden,
  number,
  percentage,
  progressBar;

  static ReaderSettingsPageNumType fromString(
    String? value, {
    ReaderSettingsPageNumType defaultValue = number,
  }) {
    if (value == null) {
      return defaultValue;
    }
    return ReaderSettingsPageNumType.values
            .firstWhereOrNull((e) => e.toString() == value) ??
        defaultValue;
  }
}
