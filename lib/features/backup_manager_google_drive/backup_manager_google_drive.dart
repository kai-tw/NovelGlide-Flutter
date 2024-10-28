import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/backup_manager_google_drive_bloc.dart';
import 'widgets/backup_manager_google_drive_all.dart';
import 'widgets/backup_manager_google_drive_bookmarks.dart';
import 'widgets/backup_manager_google_drive_books.dart';
import 'widgets/backup_manager_google_drive_collections.dart';
import 'widgets/backup_manager_google_drive_switcher.dart';
import 'widgets/backup_manager_google_drive_time_tile.dart';

class BackupManagerGoogleDrive extends StatelessWidget {
  const BackupManagerGoogleDrive({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BackupManagerGoogleDriveCubit(),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(24.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BackupManagerGoogleDriveSwitcher(),
            BackupManagerGoogleDriveTimeTile(),
            Divider(),
            BackupManagerGoogleDriveAll(),
            BackupManagerGoogleDriveBooks(),
            BackupManagerGoogleDriveCollections(),
            BackupManagerGoogleDriveBookmarks(),
          ],
        ),
      ),
    );
  }
}
