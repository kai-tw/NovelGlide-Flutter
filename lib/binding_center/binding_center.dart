import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BindingCenter extends WidgetsFlutterBinding with ThemeBinding {
  static ThemeBinding ensureInitialized() {
    if (ThemeBinding._instance == null) {
      BindingCenter();
    }
    return ThemeBinding.instance;
  }
}

mixin ThemeBinding on BindingBase {
  static ThemeBinding get instance => BindingBase.checkInstance(_instance);
  static ThemeBinding? _instance;

  final Map<String, Function(Brightness)> _brightnessListeners = {};

  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
    platformDispatcher.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
  }

  void addBrightnessListener(String key, Function(Brightness) listener) {
    _brightnessListeners[key] = listener;
  }

  void _onPlatformBrightnessChanged () {
    final Brightness brightness = platformDispatcher.platformBrightness;

    for (Function(Brightness) listener in _brightnessListeners.values) {
      listener(brightness);
    }
  }
}