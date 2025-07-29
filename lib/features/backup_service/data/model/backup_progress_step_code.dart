part of '../../backup_service.dart';

enum BackupProgressStepCode {
  disabled,
  create,
  zip,
  upload,
  unzip,
  download,
  delete,
  done,
  error
}
