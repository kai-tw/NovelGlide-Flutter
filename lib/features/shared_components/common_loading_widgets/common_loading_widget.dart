import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../generated/i18n/app_localizations.dart';

/// A loading indicator.
class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({
    super.key,
    this.title,
    this.progress,
  });

  final String? title;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            progress == null ? _buildLoading(context) : _buildProgress(context),
            Text(title ?? appLocalizations.generalLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: Theme.of(context).colorScheme.primary,
      size: 50.0,
    );
  }

  Widget _buildProgress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        value: progress!,
      ),
    );
  }
}
