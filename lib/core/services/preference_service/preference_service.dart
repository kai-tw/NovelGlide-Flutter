import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../enum/sort_order_code.dart';
import '../../../features/reader/domain/entities/reader_page_num_type.dart';
import '../../../features/shared_components/shared_list/shared_list.dart';
import 'data/model/reader_preference_data.dart';

part 'data/keys/backup_preference_key.dart';
part 'data/keys/reader_preference_key.dart';
part 'data/keys/shared_list_preference_key.dart';
part 'data/model/backup_preference_data.dart';
part 'data/repository/backup_preference.dart';
part 'data/repository/bookmark_list_preference.dart';
part 'data/repository/bookshelf_preference.dart';
part 'data/repository/collection_list_preference.dart';
part 'data/repository/preference_repository.dart';
part 'data/repository/reader_preference.dart';
part 'data/repository/shared_list_preference.dart';

class PreferenceService {
  const PreferenceService._();

  static final BackupPreference backup = BackupPreference();
  static BookmarkListPreference bookmarkList = BookmarkListPreference();
  static final BookshelfPreference bookshelf = BookshelfPreference();
  static CollectionListPreference collectionList = CollectionListPreference();
  static final ReaderPreference reader = ReaderPreference();
}
