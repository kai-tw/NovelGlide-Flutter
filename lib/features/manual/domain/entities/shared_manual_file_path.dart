enum SharedManualFilePath {
  explore('explore');

  const SharedManualFilePath(this.filePath);

  final String filePath;

  @override
  String toString() => filePath;

  static const String assetRootPath = 'assets/manuals/';
}
