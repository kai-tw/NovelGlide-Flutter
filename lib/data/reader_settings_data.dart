import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

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

  factory ReaderSettingsData.fromJson(Map<String, dynamic> json) {
    return ReaderSettingsData(
      fontSize: json['font_size'] ?? defaultFontSize,
      lineHeight: json['line_height'] ?? defaultLineHeight,
      autoSave: json['auto_save'] ?? false,
      gestureDetection: json['gesture_detection'] ?? true,
    );
  }

  factory ReaderSettingsData.load() {
    final Box readerSetting = Hive.box(name: 'settings');
    final Map<String, dynamic>? json = readerSetting.get('reader_settings');
    readerSetting.close();
    return json != null ? ReaderSettingsData.fromJson(json) : const ReaderSettingsData();
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

  void save() {
    final Box readerSettings = Hive.box(name: 'settings');
    readerSettings.put('reader_settings', toJson());
    readerSettings.close();
  }
}
