import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import '../backup_manager_google_drive/backup_manager_google_drive.dart';

class BackupManagerScaffold extends StatelessWidget {
  const BackupManagerScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
        title: Text(appLocalizations.backupManagerTitle),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BackupManagerGoogleDrive(),
            ],
          ),
        ),
      ),
    );
  }
}
