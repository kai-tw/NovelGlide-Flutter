enum ChapterRegExp {
  chinesePattern(r'第(?<chapterNumber>\d+)(話|章)(?<title>.+)');

  const ChapterRegExp(this.pattern);
  final String pattern;
}