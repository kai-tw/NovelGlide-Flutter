import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../generated/i18n/app_localizations.dart';

/// A loading indicator.
class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key, this.title, this.progress});

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

/// The sliver version of [CommonLoading].
class CommonSliverLoading extends StatelessWidget {
  const CommonSliverLoading({super.key, this.title, this.progress});

  final String? title;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: CommonLoading(title: title, progress: progress),
    );
  }
}

/// A dialog that displays a loading indicator for backup management operations.
class CommonLoadingDialog extends StatelessWidget {
  const CommonLoadingDialog({super.key, this.title, this.progress});

  final String? title;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 200.0,
        height: 100.0,
        child: CommonLoading(
          title: title,
          progress: progress,
        ),
      ),
    );
  }
}
