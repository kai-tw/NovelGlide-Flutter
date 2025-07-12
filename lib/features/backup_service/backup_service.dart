import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../core/services/log_service.dart';
import '../../core/utils/random_utils.dart';
import '../bookmark/data/bookmark_repository.dart';
import '../collection/data/collection_repository.dart';
import 'data/repository/backup_repository.dart';

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
}
