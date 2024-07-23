import 'package:flutter/material.dart';

class CommonCheckboxListTile extends StatelessWidget {
  final Widget? child;
  final bool? tristate;
  final bool? value;
  final Color? activeColor;
  final Color? checkColor;
  final Function(bool?) onChanged;
  final String? semanticLabel;

  const CommonCheckboxListTile({
    super.key,
    this.child,
    this.value,
    this.activeColor,
    this.checkColor,
    required this.onChanged,
    this.semanticLabel,
    this.tristate,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: value == true
            ? activeColor ?? Theme.of(context).colorScheme.surfaceContainer
            : Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: InkWell(
        onTap: () => onChanged(null),
        child: Row(
          children: [
            Checkbox(
              tristate: tristate ?? false,
              value: value,
              activeColor: Colors.transparent,
              checkColor: checkColor,
              onChanged: (value) => onChanged(value),
              semanticLabel: semanticLabel,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
