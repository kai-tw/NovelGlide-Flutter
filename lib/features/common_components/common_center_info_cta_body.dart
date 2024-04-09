import 'package:flutter/material.dart';

class CommonCenterInfoCTABody extends StatelessWidget {
  const CommonCenterInfoCTABody({super.key, required this.content, required this.actionText, this.onPressed});

  final String content;
  final String actionText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content),
          const Padding(padding: EdgeInsets.only(bottom: 24.0)),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(actionText),
                  const Padding(padding: EdgeInsets.only(right: 4.0)),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}