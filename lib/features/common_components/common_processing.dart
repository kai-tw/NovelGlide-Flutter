import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonProcessing extends StatelessWidget {
  const CommonProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.beat(
          color: Theme.of(context).colorScheme.primary,
          size: 50.0,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24.0)),
        Text(AppLocalizations.of(context)!.processing),
      ],
    );
  }
}