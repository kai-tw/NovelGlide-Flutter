enum SharedManualFilePath {
  explore('Explore');

  const SharedManualFilePath(this.filePath);

  final String filePath;

  @override
  String toString() => filePath;

  static const String rootUrl = 'https://repo.kai-wu.net/NovelGlide-Manual/';
}
