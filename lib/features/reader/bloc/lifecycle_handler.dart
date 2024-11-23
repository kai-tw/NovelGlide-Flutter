part of '../reader.dart';

class _LifecycleHandler {
  final ReaderCubit readerCubit;
  late final AppLifecycleListener _listener =
      AppLifecycleListener(onStateChange: _onStateChanged);

  _LifecycleHandler(this.readerCubit);

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      readerCubit._serverHandler.stop();
    }
  }

  void dispose() {
    _listener.dispose();
  }
}
