import 'package:flutter/material.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../../../../manual/presentation/cubit/shared_manual_file_path.dart';
import '../../../../../manual/presentation/shared_manual.dart';

class ExploreBrowserToManualButton extends StatelessWidget {
  const ExploreBrowserToManualButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => SharedManual(
              title: appLocalizations.exploreManual,
              filePath: SharedManualFilePath.explore,
            ),
          ),
        );
      },
      icon: const Icon(Icons.help_outline_rounded),
      tooltip: appLocalizations.generalManual,
    );
  }
}
