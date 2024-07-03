import 'package:flutter/material.dart';

class ReaderSettingsSlider extends StatelessWidget {
  final Widget leftIcon;
  final Widget rightIcon;
  final double min;
  final double max;
  final double value;
  final void Function(double) onChanged;
  final void Function(double) onChangeEnd;

  const ReaderSettingsSlider({
    super.key,
    required this.leftIcon,
    required this.rightIcon,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          width: 32,
          child: leftIcon,
        ),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            value: value,
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8.0),
          width: 32,
          child: rightIcon,
        ),
      ],
    );
  }
}