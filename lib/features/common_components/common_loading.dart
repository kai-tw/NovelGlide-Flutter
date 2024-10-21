import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonLoading extends StatelessWidget {
  final String? title;

  const CommonLoading({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.primary,
              size: 50.0,
            ),
            Text(title ?? appLocalizations.generalLoading),
          ],
        ),
      ),
    );
  }
}

class CommonSliverLoading extends StatelessWidget {
  final String? title;

  const CommonSliverLoading({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: CommonLoading(title: title),
    );
  }
}
