import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class ReaderSettingsData extends Equatable {
  final double fontSize;
  static const double minFontSize = 12;
  static const double maxFontSize = 32;

  final double lineHeight;
  static const double minLineHeight = 1;
  static const double maxLineHeight = 3;

  final bool autoSave;

  @override
  List<Object?> get props => [fontSize, lineHeight, autoSave];

  const ReaderSettingsData({
    this.fontSize = 16,
    this.lineHeight = 1.2,
    this.autoSave = false,
  });

  factory ReaderSettingsData.load() {
    final Box readerSetting = Hive.box(name: 'reader_settings');
    final double fontSize = readerSetting.get('font_size', defaultValue: 16.0).clamp(minFontSize, maxFontSize);
    final double lineHeight = readerSetting.get('line_height', defaultValue: 1.2).clamp(minLineHeight, maxLineHeight);
    final bool autoSave = readerSetting.get('auto_save', defaultValue: false);
    readerSetting.close();
    return ReaderSettingsData(
      fontSize: fontSize,
      lineHeight: lineHeight,
      autoSave: autoSave,
    );
  }

  ReaderSettingsData copyWith({
    double? fontSize,
    double? lineHeight,
    bool? autoSave,
  }) {
    return ReaderSettingsData(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight: (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
      autoSave: autoSave ?? this.autoSave,
    );
  }

  void save() {
    Box readerSettings = Hive.box(name: 'reader_settings');
    readerSettings.put('font_size', fontSize.clamp(minFontSize, maxFontSize));
    readerSettings.put('line_height', lineHeight.clamp(minLineHeight, maxLineHeight));
    readerSettings.put('auto_save', autoSave);
    readerSettings.close();
  }
}
