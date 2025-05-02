import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../core/services/file_path.dart';
import '../../core/services/google_drive_service.dart';
import '../../core/utils/datetime_utils.dart';
import '../../core/utils/route_utils.dart';
import '../common_components/common_delete_dialog.dart';
import '../common_components/common_error_dialog.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../common_components/common_success_dialog.dart';

part 'bloc/google_drive_cubit.dart';
part 'cards/backup_card.dart';
part 'cards/card_template.dart';
part 'cards/device_info_card.dart';
part 'cards/dialog_card.dart';
part 'cards/file_path_card.dart';
part 'cards/firebase_card.dart';
part 'cards/google_drive_card.dart';
part 'dialog/backup_progress_dialog.dart';
part 'widgets/google_drive_bottom_sheet.dart';
part 'widgets/google_drive_file_manager.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Page'),
      ),
      body: SafeArea(
        child: ListView(
          children: const <Widget>[
            _DeviceInfoCard(),
            _FilePathCard(),
            _DialogCard(),
            _BackupCard(),
            _FirebaseCard(),
            _GoogleDriveCard(),
          ],
        ),
      ),
    );
  }
}
