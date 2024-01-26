import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class ReaderSettings extends Equatable {
  final double fontSize;
  static const double minFontSize = 12;
  static const double maxFontSize = 32;

  final double lineHeight;
  static const double minLineHeight = 1;
  static const double maxLineHeight = 3;

  const ReaderSettings({
    this.fontSize = 16,
    this.lineHeight = 1.2,
  });

  ReaderSettings copyWith({
    double? fontSize,
    double? lineHeight,
  }) {
    return ReaderSettings(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
    );
  }

  ReaderSettings load() {
    Box readerSetting = Hive.box(name: 'reader_settings');
    double? fontSize = readerSetting.get('font_size');
    double? lineHeight = readerSetting.get('line_height');
    readerSetting.close();
    return copyWith(fontSize: fontSize, lineHeight: lineHeight);
  }

  void save() {
    Box readerSettings = Hive.box(name: 'reader_settings');
    readerSettings.put('font_size', fontSize);
    readerSettings.put('line_height', lineHeight);
    readerSettings.close();
  }

  @override
  List<Object?> get props => [fontSize, lineHeight];
}
