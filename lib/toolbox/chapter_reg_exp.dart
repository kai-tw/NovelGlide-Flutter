enum ChapterRegExp {
  chinesePattern(r'第(?<chapterNumber>(\d|零|一|二|三|四|五|六|七|八|九|十|百|千|萬|億)+)(話|章)(?<title>.+)');

  const ChapterRegExp(this.pattern);
  final String pattern;
}