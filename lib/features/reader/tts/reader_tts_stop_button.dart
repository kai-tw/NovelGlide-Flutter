import 'package:flutter/material.dart';

class ReaderTtsStopButton extends StatelessWidget {
  const ReaderTtsStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.stop_rounded),
      tooltip: "Stop",
      onPressed: () => print("Stop"),
    );
  }
}
