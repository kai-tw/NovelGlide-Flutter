import 'package:flutter/material.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../../manual/discover_manual.dart';

class DiscoverBrowserToManualButton extends StatelessWidget {
  const DiscoverBrowserToManualButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const DiscoverManual(),
          ),
        );
      },
      icon: const Icon(Icons.help_outline_rounded),
      tooltip: 'Manual',
    );
  }
}
