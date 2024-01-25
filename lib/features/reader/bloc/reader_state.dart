import 'package:equatable/equatable.dart';

class ReaderState extends Equatable {
  final double fontSize;
  static const double minFontSize = 12;
  static const double maxFontSize = 32;

  final double lineHeight;
  static const double minLineHeight = 1;
  static const double maxLineHeight = 3;

  const ReaderState({
    this.fontSize = 16,
    this.lineHeight = 1.2,
  });

  ReaderState copyWith({
    double? fontSize,
    double? lineHeight,
  }) {
    return ReaderState(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight: (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
    );
  }

  @override
  List<Object?> get props => [fontSize, lineHeight];
}
