import 'package:flutter/material.dart';

class RouteUtils {
  // Creates a route with a slide transition from right to left
  static Route pushRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => destination,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position: Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        )
            .chain(
              CurveTween(curve: Curves.easeInOutCubicEmphasized),
            )
            .animate(animation),
        child: child,
      ),
    );
  }
}
