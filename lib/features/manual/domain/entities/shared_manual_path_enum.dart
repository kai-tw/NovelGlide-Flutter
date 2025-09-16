enum SharedManualPathEnum {
  explore(SharedManualLoadType.local, 'explore'),
  privacyPolicy(SharedManualLoadType.remote, 'privacy_policy');

  const SharedManualPathEnum(
    this.loadType,
    this.filePath,
  );

  final SharedManualLoadType loadType;
  final String filePath;

  @override
  String toString() => filePath;
}

enum SharedManualLoadType { local, remote, both }
