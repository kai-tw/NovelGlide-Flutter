import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import 'bloc/backup_manager_google_drive_select_bloc.dart';

class BackupManagerGoogleDriveBottomSheet extends StatelessWidget {
  final drive.File file;

  const BackupManagerGoogleDriveBottomSheet({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final BackupManagerGoogleDriveSelectCubit cubit = BlocProvider.of<BackupManagerGoogleDriveSelectCubit>(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.25,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      builder: (sheetContext, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
              leading: const Icon(Icons.folder_zip_rounded),
              title: Text(file.name ?? appLocalizations.fileSystemUntitledFile),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                if (file.id != null) {
                  cubit.restoreBackup(file.id!);
                  Navigator.of(sheetContext).pop();
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
              leading: const Icon(Icons.restore_rounded),
              title: Text(appLocalizations.backupManagerRestoreBackup),
            ),
            ListTile(
              onTap: () {
                if (file.id != null) {
                  cubit.deleteFile(file.id!);
                  Navigator.of(sheetContext).pop();
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
              leading: const Icon(Icons.delete_rounded),
              title: Text(appLocalizations.backupManagerDeleteBackup),
            ),
            ListTile(
              onTap: () {
                if (file.id != null) {
                  cubit.copyToDrive(file.id!);
                  Navigator.of(sheetContext).pop();
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
              leading: const Icon(Icons.copy_rounded),
              title: Text(appLocalizations.backupManagerGoogleDriveCopy),
            ),
          ],
        );
      },
    );
  }
}