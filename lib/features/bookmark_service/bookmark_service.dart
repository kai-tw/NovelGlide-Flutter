import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/file_system_service/file_system_service.dart';
import '../../core/services/preference_service/preference_service.dart';
import '../../core/utils/popup_menu_utils.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../features/shared_components/common_delete_dialog.dart';
import '../../features/shared_components/common_loading.dart';
import '../../features/shared_components/draggable_feedback_widget.dart';
import '../../features/shared_components/draggable_placeholder_widget.dart';
import '../../features/shared_components/shared_list/shared_list.dart';
import '../../generated/i18n/app_localizations.dart';
import '../books/book_service.dart';
import '../homepage/cubit/homepage_cubit.dart';
import '../homepage/homepage.dart';
import '../reader/presentation/reader_page/cubit/reader_cubit.dart';
import '../reader/presentation/reader_page/reader.dart';

part 'data/bookmark_data.dart';
part 'data/bookmark_repository.dart';
part 'presentation/bookmark_list/bookmark_list.dart';
part 'presentation/bookmark_list/bookmark_list_app_bar.dart';
part 'presentation/bookmark_list/bookmark_list_scaffold_body.dart';
part 'presentation/bookmark_list/cubit/bookmark_list_cubit.dart';
part 'presentation/bookmark_list/widgets/bookmark_list_app_bar_more_button.dart';
part 'presentation/bookmark_list/widgets/bookmark_list_bookmark_widget.dart';
part 'presentation/bookmark_list/widgets/bookmark_list_draggable_bookmark.dart';
part 'presentation/bookmark_list/widgets/bookmark_list_item.dart';

class BookmarkService {
  BookmarkService._();

  static BookmarkRepository repository = BookmarkRepository();
}
