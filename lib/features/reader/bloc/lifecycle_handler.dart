part of '../reader.dart';

class _LifecycleHandler {
  final _ReaderCubit _readerCubit;
  late final AppLifecycleListener _listener =
      AppLifecycleListener(onStateChange: _onStateChanged);

  _LifecycleHandler(this._readerCubit);

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _readerCubit._serverHandler.stop();
    }
  }

  void dispose() {
    _listener.dispose();
  }
}
