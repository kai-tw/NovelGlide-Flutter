import 'package:flutter/material.dart';

class RouteUtils {
  RouteUtils._();

  // Creates a route with a slide transition from right to left
  static Route<T> pushRoute<T>(Widget destination) {
    return MaterialPageRoute<T>(builder: (_) => destination);
  }
}
