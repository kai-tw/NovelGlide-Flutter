import 'package:flutter/material.dart';

import '../../../generated/i18n/app_localizations.dart';
import 'google_drive/backup_service_google_drive.dart';

class BackupServicePage extends StatelessWidget {
  const BackupServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.generalBackup),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BackupServiceGoogleDrive(),
            ],
          ),
        ),
      ),
    );
  }
}
