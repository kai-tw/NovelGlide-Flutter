part of 'process_cubit.dart';

enum BackupManagerProcessStepCode {
  idle,
  zip,
  upload,
  unzip,
  download,
  delete,
  done,
  error
}
