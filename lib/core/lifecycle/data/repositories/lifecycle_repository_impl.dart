import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/repositories/lifecycle_repository.dart';

class LifecycleRepositoryImpl implements LifecycleRepository {
  factory LifecycleRepositoryImpl() {
    final LifecycleRepositoryImpl instance = LifecycleRepositoryImpl._();

    AppLifecycleListener(
      onShow: () => instance._onShow.add(null),
      onDetach: () => instance._onDetach.add(null),
      onResume: () => instance._onResume.add(null),
      onInactive: () => instance._onInactive.add(null),
      onHide: () => instance._onHide.add(null),
      onPause: () => instance._onPause.add(null),
    );

    return instance;
  }

  LifecycleRepositoryImpl._();

  final StreamController<void> _onShow = StreamController<void>.broadcast();
  final StreamController<void> _onDetach = StreamController<void>.broadcast();
  final StreamController<void> _onResume = StreamController<void>.broadcast();
  final StreamController<void> _onInactive = StreamController<void>.broadcast();
  final StreamController<void> _onHide = StreamController<void>.broadcast();
  final StreamController<void> _onPause = StreamController<void>.broadcast();

  @override
  Stream<void> get onShow => _onShow.stream;

  @override
  Stream<void> get onDetach => _onDetach.stream;

  @override
  Stream<void> get onResume => _onResume.stream;

  @override
  Stream<void> get onInactive => _onInactive.stream;

  @override
  Stream<void> get onHide => _onHide.stream;

  @override
  Stream<void> get onPause => _onPause.stream;
}
