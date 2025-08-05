import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/random_extension.dart';
import '../../core/services/file_system_service/file_system_service.dart';
import '../../features/shared_components/adaptive_lines_text.dart';
import '../../features/shared_components/common_delete_dialog.dart';
import '../../features/shared_components/common_loading.dart';
import '../../features/shared_components/draggable_feedback_widget.dart';
import '../../features/shared_components/draggable_placeholder_widget.dart';
import '../../features/shared_components/shared_list/shared_list.dart';
import '../../core/utils/popup_menu_utils.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../enum/window_size.dart';
import '../../generated/i18n/app_localizations.dart';
import '../book_service/book_service.dart';
import '../homepage/cubit/homepage_cubit.dart';
import '../homepage/homepage.dart';
import 'presentation/collection_list/cubit/collection_list_cubit.dart';
import 'presentation/collection_viewer/collection_viewer.dart';

part 'data/collection_data.dart';
part 'data/collection_repository.dart';
part 'presentation/add_book_page/collection_add_book_scaffold.dart';
part 'presentation/add_book_page/cubit/collection_add_book_cubit.dart';
part 'presentation/add_book_page/cubit/collection_add_book_state.dart';
part 'presentation/add_book_page/widgets/collection_add_book_list.dart';
part 'presentation/add_book_page/widgets/collection_add_book_list_item.dart';
part 'presentation/add_book_page/widgets/collection_add_book_navigation.dart';
part 'presentation/add_dialog/collection_add_dialog.dart';
part 'presentation/add_dialog/cubit/collection_add_cubit.dart';
part 'presentation/add_dialog/cubit/collection_add_state.dart';
part 'presentation/add_dialog/widgets/collection_add_cancel_button.dart';
part 'presentation/add_dialog/widgets/collection_add_form.dart';
part 'presentation/add_dialog/widgets/collection_add_name_field.dart';
part 'presentation/add_dialog/widgets/collection_add_submit_button.dart';
part 'presentation/collection_list/collection_list.dart';
part 'presentation/collection_list/collection_list_app_bar.dart';
part 'presentation/collection_list/collection_list_scaffold_body.dart';
part 'presentation/collection_list/widgets/collection_list_app_bar_more_button.dart';
part 'presentation/collection_list/widgets/collection_list_collection_widget.dart';
part 'presentation/collection_list/widgets/collection_list_draggable_collection.dart';
part 'presentation/collection_list/widgets/collection_list_item.dart';

class CollectionService {
  CollectionService._();

  static CollectionRepository repository = CollectionRepository();
}
