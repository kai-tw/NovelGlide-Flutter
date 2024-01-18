import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonSliverLoading extends StatelessWidget {
  const CommonSliverLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: SizedBox(
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.primary,
              size: 50.0,
            ),
            Text(AppLocalizations.of(context)!.loading),
          ],
        ),
      ),
    );
  }
}
