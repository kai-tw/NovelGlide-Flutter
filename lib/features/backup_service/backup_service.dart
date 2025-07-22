import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../core/domains/file_system_domain/file_system_domain.dart';
import '../../core/domains/log_domain/log_domain.dart';
import '../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../bookmark_service/bookmark_service.dart';
import '../collection/collection_service.dart';

part 'data/repository/backup_repository.dart';
part 'presentation/process_dialog/cubit/enum/backup_service_process_step_code.dart';
part 'presentation/process_dialog/cubit/enum/backup_service_target_type.dart';
part 'presentation/process_dialog/cubit/enum/backup_service_task_type.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_bookmark_cubit.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_collection_cubit.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_item_cubit.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_library_cubit.dart';
part 'presentation/process_dialog/cubit/states/backup_service_process_item_state.dart';

class BackupService {
  BackupService._();

  static final BackupRepository repository = BackupRepository();
}
