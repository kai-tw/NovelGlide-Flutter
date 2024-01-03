import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  const CenteredText(this.string, {super.key});

  final String string;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(string, textAlign: TextAlign.center));
  }
}
