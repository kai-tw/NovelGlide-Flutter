import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonProcessingDialog extends StatelessWidget {
  const CommonProcessingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: LoadingAnimationWidget.beat(
        color: Theme.of(context).colorScheme.secondary,
        size: 40.0,
      ),
      content: Text(
        AppLocalizations.of(context)!.processing,
        textAlign: TextAlign.center,
      ),
    );
  }
}