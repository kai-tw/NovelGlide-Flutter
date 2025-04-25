part of 'backup_service_process_cubit.dart';

enum BackupServiceProcessStepCode {
  disabled,
  idle,
  zip,
  upload,
  unzip,
  download,
  delete,
  done,
  error
}
