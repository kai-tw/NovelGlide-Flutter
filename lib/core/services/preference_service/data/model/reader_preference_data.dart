import 'package:equatable/equatable.dart';

import '../../../../../features/reader/data/model/reader_page_num_type.dart';

/// Represents the settings for a reader, including font size, line height, and other preferences.
class ReaderPreferenceData extends Equatable {
  const ReaderPreferenceData({
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

  final ReaderPageNumType pageNumType;
  static const ReaderPageNumType defaultPageNumType = ReaderPageNumType.number;

  @override
  List<Object?> get props => <Object?>[
        fontSize,
        lineHeight,
        isAutoSaving,
        isSmoothScroll,
        pageNumType,
      ];

  /// Creates a copy of the current settings with optional new values.
  ReaderPreferenceData copyWith({
    double? fontSize,
    double? lineHeight,
    bool? isAutoSaving,
    bool? isSmoothScroll,
    ReaderPageNumType? pageNumType,
  }) {
    return ReaderPreferenceData(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight:
          (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
      isAutoSaving: isAutoSaving ?? this.isAutoSaving,
      isSmoothScroll: isSmoothScroll ?? this.isSmoothScroll,
      pageNumType: pageNumType ?? this.pageNumType,
    );
  }
}
