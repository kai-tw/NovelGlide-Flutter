import 'package:flutter/material.dart';

import '../../generated/i18n/app_localizations.dart';
import '../common_components/common_back_button.dart';
import 'google_drive/backup_service_google_drive.dart';

class BackupServicePage extends StatelessWidget {
  const BackupServicePage({super.key});

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
            children: <Widget>[
              BackupServiceGoogleDrive(),
            ],
          ),
        ),
      ),
    );
  }
}
