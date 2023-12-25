import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});
  final String title = "Settings";

  @override
  Widget build(BuildContext context) {
    return const Card(
        shadowColor: Colors.transparent,
        child: Center(
            child: Text("Settings")
        )
    );
  }
}