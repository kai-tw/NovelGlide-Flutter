import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/file_path.dart';
import '../../../../core/utils/epub_utils.dart';
import '../../../../core/utils/file_utils.dart';
import '../../enum/sort_order_code.dart';
import '../../preference_keys/preference_keys.dart';
import '../bookmark/data/bookmark_repository.dart';
import '../collection/data/collection_repository.dart';
import '../reader/data/repository/cache_repository.dart';
import 'data/model/book_data.dart';

part 'data/repository/book_preferences.dart';
part 'data/repository/book_repository.dart';

class BookService {
  BookService._();

  static final BookPreference preference = BookPreference();
  static final BookRepository repository = BookRepository();
}
