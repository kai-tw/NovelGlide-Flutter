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

  @override
  List<Object?> get props => [fontSize, lineHeight, autoSave, gestureDetection];

  const ReaderSettingsData({
    this.fontSize = defaultFontSize,
    this.lineHeight = defaultLineHeight,
    this.autoSave = false,
    this.gestureDetection = true,
  });

  /// Loads the reader settings from shared preferences.
  static Future<ReaderSettingsData> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return ReaderSettingsData(
      fontSize:
          prefs.getDouble(PreferenceKeys.reader.fontSize) ?? defaultFontSize,
      lineHeight: prefs.getDouble(PreferenceKeys.reader.lineHeight) ??
          defaultLineHeight,
      autoSave: prefs.getBool(PreferenceKeys.reader.autoSave) ?? false,
      gestureDetection:
          prefs.getBool(PreferenceKeys.reader.gestureDetection) ?? true,
    );
  }

  /// Creates a copy of the current settings with optional new values.
  ReaderSettingsData copyWith({
    double? fontSize,
    double? lineHeight,
    bool? autoSave,
    bool? gestureDetection,
  }) {
    return ReaderSettingsData(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight:
          (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
      autoSave: autoSave ?? this.autoSave,
      gestureDetection: gestureDetection ?? this.gestureDetection,
    );
  }

  /// Converts the settings to a JSON map.
  Map<String, dynamic> toJson() => {
        'font_size': fontSize,
        'line_height': lineHeight,
        'auto_save': autoSave,
        'gesture_detection': gestureDetection,
      };

  /// Saves the current settings to shared preferences.
  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(PreferenceKeys.reader.fontSize, fontSize);
    prefs.setDouble(PreferenceKeys.reader.lineHeight, lineHeight);
    prefs.setBool(PreferenceKeys.reader.autoSave, autoSave);
    prefs.setBool(PreferenceKeys.reader.gestureDetection, gestureDetection);
  }

  /// Checks if the style settings have changed compared to another instance.
  bool isStyleChanged(ReaderSettingsData other) {
    return fontSize != other.fontSize || lineHeight != other.lineHeight;
  }
}
