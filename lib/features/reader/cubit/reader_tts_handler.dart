part of 'reader_cubit.dart';

class ReaderTTSHandler {
  final TtsService ttsService;

  factory ReaderTTSHandler({required void Function() onReady}) {
    return ReaderTTSHandler._(
      ttsService: TtsService(onReady: onReady),
    );
  }

  ReaderTTSHandler._({
    required this.ttsService,
  });
}
