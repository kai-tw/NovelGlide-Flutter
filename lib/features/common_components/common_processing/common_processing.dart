import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonProcessing extends StatelessWidget {
  const CommonProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        LoadingAnimationWidget.beat(
          color: Theme.of(context).colorScheme.primary,
          size: 48.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text(AppLocalizations.of(context)!.processing),
        ),
      ],
    );
  }
}
