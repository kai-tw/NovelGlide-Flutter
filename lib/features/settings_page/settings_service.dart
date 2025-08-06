import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/widgets/app_version_widget.dart';
import '../../enum/window_size.dart';
import '../../generated/i18n/app_localizations.dart';
import '../appearance/presentation/appearance_settings_page/appearance_settings_page.dart';
import '../backup_service/presentation/backup_service_page.dart';
import '../developer_page/developer_page.dart';
import '../feedback_service/presentation/feedback_page.dart';
import '../homepage/homepage.dart';
import '../locale_system/locale_utils.dart';
import '../reset_services/reset_service.dart';
import '../tts_service/tts_service.dart';

part 'presentation/settings_app_bar.dart';
part 'presentation/settings_page.dart';
part 'presentation/widgets/settings_card.dart';
part 'presentation/widgets/settings_list_tile.dart';

class SettingsService {
  const SettingsService();
}
