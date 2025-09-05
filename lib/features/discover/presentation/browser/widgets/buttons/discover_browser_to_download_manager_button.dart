import 'package:flutter/material.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../../../../download_manager/presentation/download_manager/download_manager.dart';

class DiscoverBrowserToDownloadManagerButton extends StatelessWidget {
  const DiscoverBrowserToDownloadManagerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const DownloadManager(),
          ),
        );
      },
      icon: const Icon(Icons.download_rounded),
      tooltip: appLocalizations.generalDownload(2),
    );
  }
}
