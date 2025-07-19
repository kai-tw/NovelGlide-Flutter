import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../core/services/file_path.dart';
import '../../../core/utils/json_utils.dart';
import '../../../core/utils/random_utils.dart';
import '../../core/shared_components/common_delete_dialog.dart';
import '../../core/shared_components/common_loading.dart';
import '../../core/shared_components/draggable_feedback_widget.dart';
import '../../core/shared_components/draggable_placeholder_widget.dart';
import '../../core/shared_components/shared_list/shared_list.dart';
import '../../core/utils/popup_menu_utils.dart';
import '../../core/utils/route_utils.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../enum/window_size.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../preference_keys/preference_keys.dart';
import '../book_service/book_service.dart';
import '../homepage/cubit/homepage_cubit.dart';
import '../homepage/homepage.dart';
import 'presentation/collection_list/cubit/cubit.dart';
import 'presentation/collection_viewer/collection_viewer.dart';

part 'data/collection_data.dart';
part 'data/collection_preference.dart';
part 'data/collection_repository.dart';
part 'presentation/collection_list/collection_list.dart';
part 'presentation/collection_list/collection_list_app_bar.dart';
part 'presentation/collection_list/collection_list_scaffold_body.dart';
part 'presentation/collection_list/widgets/collection_list_app_bar_more_button.dart';
part 'presentation/collection_list/widgets/collection_list_collection_widget.dart';
part 'presentation/collection_list/widgets/collection_list_draggable_collection.dart';
part 'presentation/collection_list/widgets/collection_list_item.dart';

class CollectionService {
  CollectionService._();

  static CollectionPreference preference = CollectionPreference();
  static CollectionRepository repository = CollectionRepository();
}
