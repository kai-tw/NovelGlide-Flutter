import 'package:flutter/material.dart';

class DeviceInfoPanel extends StatelessWidget {
  const DeviceInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("devicePixelRatio: ${MediaQuery.of(context).devicePixelRatio}"),
            Text("size.width: ${MediaQuery.of(context).size.width}"),
            Text("size.height: ${MediaQuery.of(context).size.height}"),
            Text("Orientation: ${MediaQuery.of(context).orientation}"),
            Text("Platform brightness: ${MediaQuery.of(context).platformBrightness}"),
          ],
        ),
      ),
    );
  }
}