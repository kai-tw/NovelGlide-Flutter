import 'package:flutter/material.dart';

class RouteUtils {
  // Creates a route with a slide transition from right to left
  static Route pushRoute(Widget destination) {
    return MaterialPageRoute(builder: (_) => destination);
  }
}
