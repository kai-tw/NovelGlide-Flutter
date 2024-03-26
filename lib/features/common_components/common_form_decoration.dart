import 'package:flutter/material.dart';

class CommonFormDecoration {
  static inputDecoration(String? labelText, {Widget? suffixIcon, EdgeInsets? padding, String? errorText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 16),
      errorText: errorText,
      contentPadding: padding ?? const EdgeInsets.all(24.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      suffixIcon: suffixIcon == null ? null : Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: suffixIcon,
      ),
    );
  }
}
