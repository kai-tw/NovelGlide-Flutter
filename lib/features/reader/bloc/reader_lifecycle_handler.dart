import 'package:flutter/material.dart';

import 'reader_cubit.dart';

class ReaderLifecycleHandler {
  final ReaderCubit _readerCubit;
  late final AppLifecycleListener _listener = AppLifecycleListener(onStateChange: _onStateChanged);

  ReaderLifecycleHandler(this._readerCubit);

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _readerCubit.serverHandler.stop();
    }
  }

  void dispose() {
    _listener.dispose();
  }
}