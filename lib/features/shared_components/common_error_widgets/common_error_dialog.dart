import 'package:flutter/material.dart';

import '../../../generated/i18n/app_localizations.dart';
import 'common_error_widget.dart';

class CommonErrorDialog extends CommonErrorWidget {
  const CommonErrorDialog({
    super.key,
    super.icon,
    this.title,
    super.content,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      icon: Icon(iconData),
      iconColor: Theme.of(context).colorScheme.error,
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
      actions: <Widget>[
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          label: Text(appLocalizations.generalClose),
        ),
      ],
    );
  }
}
