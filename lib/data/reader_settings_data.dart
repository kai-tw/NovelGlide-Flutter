import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preference_keys.dart';

class ReaderSettingsData extends Equatable {
  final double fontSize;
  static const double defaultFontSize = 16;
  static const double minFontSize = 12;
  static const double maxFontSize = 32;

  final double lineHeight;
  static const double defaultLineHeight = 1.5;
  static const double minLineHeight = 1;
  static const double maxLineHeight = 3;

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

  static Future<ReaderSettingsData> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return ReaderSettingsData(
      fontSize: prefs.getDouble(PreferenceKeys.reader.fontSize) ?? defaultFontSize,
      lineHeight: prefs.getDouble(PreferenceKeys.reader.lineHeight) ?? defaultLineHeight,
      autoSave: prefs.getBool(PreferenceKeys.reader.autoSave) ?? false,
      gestureDetection: prefs.getBool(PreferenceKeys.reader.gestureDetection) ?? true,
    );
  }

  ReaderSettingsData copyWith({
    double? fontSize,
    double? lineHeight,
    bool? autoSave,
    bool? gestureDetection,
  }) {
    return ReaderSettingsData(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight: (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
      autoSave: autoSave ?? this.autoSave,
      gestureDetection: gestureDetection ?? this.gestureDetection,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'font_size': fontSize,
        'line_height': lineHeight,
        'auto_save': autoSave,
        'gesture_detection': gestureDetection,
      };

  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(PreferenceKeys.reader.fontSize, fontSize);
    prefs.setDouble(PreferenceKeys.reader.lineHeight, lineHeight);
    prefs.setBool(PreferenceKeys.reader.autoSave, autoSave);
    prefs.setBool(PreferenceKeys.reader.gestureDetection, gestureDetection);
  }

  bool isStyleChanged(ReaderSettingsData other) {
    return fontSize != other.fontSize || lineHeight != other.lineHeight;
  }
}
