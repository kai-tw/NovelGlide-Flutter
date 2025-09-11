import 'package:flutter/material.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../../manual/explore_manual.dart';

class ExploreBrowserToManualButton extends StatelessWidget {
  const ExploreBrowserToManualButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ExploreManual(),
          ),
        );
      },
      icon: const Icon(Icons.help_outline_rounded),
      tooltip: 'Manual',
    );
  }
}
