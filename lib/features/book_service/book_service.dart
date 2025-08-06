import 'dart:async';
import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../generated/i18n/app_localizations.dart';
import '../../core/services/file_system_service/file_system_service.dart';
import '../../core/services/mime_resolver.dart';
import '../../core/utils/popup_menu_utils.dart';
import '../../enum/sort_order_code.dart';
import '../../features/shared_components/common_delete_dialog.dart';
import '../../features/shared_components/shared_list/shared_list.dart';
import '../bookmark_service/bookmark_service.dart';
import '../collection_service/collection_service.dart';
import '../homepage/cubit/homepage_cubit.dart';
import '../homepage/homepage.dart';
import '../reader/data/repository/cache_repository.dart';
import 'presentation/bookshelf/bookshelf.dart';
import 'presentation/bookshelf/cubit/bookshelf_cubit.dart';

part 'data/model/book_data.dart';
part 'data/model/chapter_data.dart';
part 'data/repository/book_repository.dart';
part 'presentation/bookshelf/bookshelf_app_bar.dart';
part 'presentation/bookshelf/bookshelf_loading_indicator.dart';
part 'presentation/bookshelf/bookshelf_scaffold_body.dart';
part 'presentation/bookshelf/widgets/bookshelf_app_bar_more_button.dart';

class BookService {
  BookService._();

  static final BookRepository repository = BookRepository();
}
