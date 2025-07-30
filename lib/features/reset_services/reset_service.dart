import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/preference_service/preference_service.dart';
import '../../core/shared_components/common_delete_dialog.dart';
import '../../core/shared_components/common_loading.dart';
import '../../core/shared_components/common_success_dialog.dart';
import '../../generated/i18n/app_localizations.dart';
import '../book_service/book_service.dart';
import '../bookmark_service/bookmark_service.dart';
import '../collection_service/collection_service.dart';
import '../collection_service/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../reader/data/model/reader_settings_data.dart';
import '../reader/data/repository/cache_repository.dart';
import '../settings_page/settings_service.dart';

part 'presentation/reset_page.dart';
part 'presentation/reset_service_settings_list_tile.dart';
part 'presentation/widgets/settings_page_cache_card.dart';
part 'presentation/widgets/settings_page_data_card.dart';
part 'presentation/widgets/settings_page_list_tile.dart';
part 'presentation/widgets/settings_page_preference_card.dart';

class ResetService {
  const ResetService();
}
