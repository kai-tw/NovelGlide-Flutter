import 'dart:io';

import 'package:bitmap/bitmap.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

import '../../../../core/services/cache_memory_image_provider.dart';
import '../../../../core/utils/epub_utils.dart';
import '../../../../core/utils/file_extension.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../core/services/file_system_service/file_system_service.dart';
import '../../core/services/mime_resolver.dart';
import '../../core/services/preference_service/preference_service.dart';
import '../../core/shared_components/adaptive_lines_text.dart';
import '../../core/shared_components/common_delete_dialog.dart';
import '../../core/shared_components/common_error_dialog.dart';
import '../../core/shared_components/common_loading.dart';
import '../../core/shared_components/draggable_feedback_widget.dart';
import '../../core/shared_components/draggable_placeholder_widget.dart';
import '../../core/shared_components/shared_list/shared_list.dart';
import '../../core/utils/popup_menu_utils.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../preference_keys/preference_keys.dart';
import '../bookmark_service/bookmark_service.dart';
import '../collection/collection_service.dart';
import '../collection/presentation/add_book_page/collection_add_book_scaffold.dart';
import '../homepage/cubit/homepage_cubit.dart';
import '../homepage/homepage.dart';
import '../reader/data/repository/cache_repository.dart';
import 'presentation/bookshelf/cubit/bookshelf_cubit.dart';
import 'presentation/table_of_contents_page/table_of_contents.dart';

part 'data/model/book_data.dart';
part 'data/model/chapter_data.dart';
part 'data/repository/book_preferences.dart';
part 'data/repository/book_repository.dart';
part 'presentation/add_page/book_add_page.dart';
part 'presentation/add_page/cubit/book_add_cubit.dart';
part 'presentation/add_page/cubit/book_add_item_state.dart';
part 'presentation/add_page/cubit/book_add_state.dart';
part 'presentation/add_page/widgets/book_add_action_bar.dart';
part 'presentation/add_page/widgets/book_add_file_list.dart';
part 'presentation/add_page/widgets/book_add_file_tile.dart';
part 'presentation/add_page/widgets/book_add_helper_text.dart';
part 'presentation/bookshelf/bookshelf.dart';
part 'presentation/bookshelf/bookshelf_app_bar.dart';
part 'presentation/bookshelf/bookshelf_loading_indicator.dart';
part 'presentation/bookshelf/bookshelf_scaffold_body.dart';
part 'presentation/bookshelf/widgets/bookshelf_app_bar_more_button.dart';
part 'presentation/bookshelf/widgets/bookshelf_book_widget.dart';
part 'presentation/bookshelf/widgets/bookshelf_cover_widget.dart';
part 'presentation/bookshelf/widgets/bookshelf_draggable_book.dart';
part 'presentation/bookshelf/widgets/bookshelf_list_item.dart';
part 'presentation/shared/book_cover_image.dart';

class BookService {
  BookService._();

  static final BookPreference preference = BookPreference();
  static final BookRepository repository = BookRepository();
}
