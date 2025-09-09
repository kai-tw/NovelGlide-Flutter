import 'package:flutter/material.dart';

import '../../../generated/i18n/app_localizations.dart';

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    super.key,
    this.icon,
    this.content,
  });

  final IconData? icon;
  final String? content;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Icon(
              iconData,
              color: Theme.of(context).colorScheme.error,
              size: 36.0,
            ),
          ),
          Text(content ?? appLocalizations.exceptionUnknownError),
        ],
      ),
    );
  }

  IconData get iconData => icon ?? Icons.error_outline_rounded;
}
