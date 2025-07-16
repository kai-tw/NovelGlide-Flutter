import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:collection/collection.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/cache_memory_image_provider.dart';
import '../../../../core/services/file_path.dart';
import '../../../../core/utils/epub_utils.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../core/shared_components/common_delete_dialog.dart';
import '../../core/shared_components/common_error_dialog.dart';
import '../../core/shared_components/common_loading.dart';
import '../../core/shared_components/draggable_feedback_widget.dart';
import '../../core/shared_components/draggable_placeholder_widget.dart';
import '../../core/shared_components/shared_list/shared_list.dart';
import '../../core/utils/popup_menu_utils.dart';
import '../../core/utils/route_utils.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/sort_order_code.dart';
import '../../preference_keys/preference_keys.dart';
import '../bookmark/data/bookmark_repository.dart';
import '../collection/data/collection_repository.dart';
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
part 'presentation/bookshelf/bookshelf.dart';
part 'presentation/bookshelf/bookshelf_app_bar.dart';
part 'presentation/bookshelf/bookshelf_loading_indicator.dart';
part 'presentation/bookshelf/bookshelf_scaffold_body.dart';
part 'presentation/bookshelf/widgets/book_widgets/bookshelf_book_grid_item.dart';
part 'presentation/bookshelf/widgets/book_widgets/bookshelf_book_list_item.dart';
part 'presentation/bookshelf/widgets/bookshelf_app_bar_more_button.dart';
part 'presentation/bookshelf/widgets/bookshelf_book_widget.dart';
part 'presentation/bookshelf/widgets/bookshelf_draggable_book.dart';
part 'presentation/bookshelf/widgets/bookshelf_list_item.dart';
part 'presentation/shared/book_cover_image.dart';

class BookService {
  BookService._();

  static final BookPreference preference = BookPreference();
  static final BookRepository repository = BookRepository();
}
