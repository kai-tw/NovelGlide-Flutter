part of '../exception_service.dart';

class GoogleDrivePermissionException implements Exception {
  GoogleDrivePermissionException({
    this.message = 'google_drive_permission_denied',
  });

  final String message;
}
