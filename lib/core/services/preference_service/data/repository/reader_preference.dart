part of '../../preference_service.dart';

class ReaderPreference extends PreferenceRepository<ReaderPreferenceData> {
  static final ReaderPreferenceKey _key = ReaderPreferenceKey();

  @override
  Future<ReaderPreferenceData> load() async {
    return ReaderPreferenceData(
      fontSize: (await tryGetDouble(_key.fontSize))?.clamp(
            ReaderPreferenceData.minFontSize,
            ReaderPreferenceData.maxFontSize,
          ) ??
          ReaderPreferenceData.defaultFontSize,
      lineHeight: (await tryGetDouble(_key.lineHeight))?.clamp(
            ReaderPreferenceData.minFontSize,
            ReaderPreferenceData.maxFontSize,
          ) ??
          ReaderPreferenceData.defaultLineHeight,
      isAutoSaving: await tryGetBool(_key.isAutoSaving) ??
          ReaderPreferenceData.defaultIsAutoSaving,
      isSmoothScroll: await tryGetBool(_key.isSmoothScroll) ??
          ReaderPreferenceData.defaultIsSmoothScroll,
      pageNumType: ReaderPageNumType.values[await tryGetInt(_key.pageNumType) ??
          ReaderPreferenceData.defaultPageNumType.index],
    );
  }

  @override
  Future<void> reset() async {
    await Future.wait(<Future<void>>[
      setDouble(_key.fontSize, ReaderPreferenceData.defaultFontSize),
      setDouble(_key.lineHeight, ReaderPreferenceData.defaultLineHeight),
      setBool(_key.isAutoSaving, ReaderPreferenceData.defaultIsAutoSaving),
      setBool(_key.isSmoothScroll, ReaderPreferenceData.defaultIsSmoothScroll),
      setInt(_key.pageNumType, ReaderPreferenceData.defaultPageNumType.index),
    ]);

    // Notify listener.
    onChangedController.add(null);
  }

  @override
  Future<void> save(ReaderPreferenceData data) async {
    await Future.wait(<Future<void>>[
      setDouble(_key.fontSize, data.fontSize),
      setDouble(_key.lineHeight, data.lineHeight),
      setBool(_key.isAutoSaving, data.isAutoSaving),
      setBool(_key.isSmoothScroll, data.isSmoothScroll),
      setInt(_key.pageNumType, data.pageNumType.index),
    ]);

    // Notify listener.
    onChangedController.add(null);
  }
}
