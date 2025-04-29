part of '../reader_bottom_sheet.dart';

class _SettingsSlider extends StatelessWidget {
  const _SettingsSlider({
    required this.leading,
    required this.trailing,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.onChangeEnd,
    this.semanticFormatterCallback,
  });

  final Widget leading;
  final Widget trailing;
  final double min;
  final double max;
  final double value;
  final void Function(double) onChanged;
  final void Function(double) onChangeEnd;
  final String Function(double)? semanticFormatterCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          width: 32,
          child: leading,
        ),
        Expanded(
          child: Slider(
              min: min,
              max: max,
              value: value,
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
              semanticFormatterCallback: semanticFormatterCallback),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8.0),
          width: 32,
          child: trailing,
        ),
      ],
    );
  }
}
