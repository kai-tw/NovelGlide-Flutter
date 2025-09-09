abstract class ReaderTtsRepository {
  // Stream play tts event
  Stream<String> get ttsPlayStream;

  // Stream stop tts event
  Stream<void> get ttsStopStream;

  // Stream tts end event
  Stream<void> get ttsEndStream;

  Future<void> dispose();
}
