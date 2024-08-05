import 'package:flutter/material.dart';

class DeviceInfoPanel extends StatelessWidget {
  const DeviceInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(36.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text("Device info", style: Theme.of(context).textTheme.titleLarge),
          ),
          Text("devicePixelRatio: ${MediaQuery.of(context).devicePixelRatio}"),
          Text("size.width: ${MediaQuery.of(context).size.width}"),
          Text("size.height: ${MediaQuery.of(context).size.height}"),
          Text("Orientation: ${MediaQuery.of(context).orientation}"),
          Text("Platform brightness: ${MediaQuery.of(context).platformBrightness}"),
        ],
      ),
    );
  }
}