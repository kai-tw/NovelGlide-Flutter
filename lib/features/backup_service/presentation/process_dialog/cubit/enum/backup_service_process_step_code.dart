part of '../../../../backup_service.dart';

enum BackupServiceProcessStepCode {
  disabled,
  backup,
  zip,
  upload,
  unzip,
  download,
  delete,
  done,
  error
}
