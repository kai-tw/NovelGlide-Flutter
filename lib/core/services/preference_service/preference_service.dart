import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../enum/sort_order_code.dart';
import '../../../features/appearance_services/appearance_services.dart';
import '../../shared_components/shared_list/shared_list.dart';

part 'data/model/appearance_preference_data.dart';
part 'data/model/locale_preference_data.dart';
part 'data/repository/appearance_preference.dart';
part 'data/repository/locale_preference.dart';
part 'data/repository/preference_repository.dart';
part 'data/repository/shared_list_preference.dart';
part 'preference_keys/backup_service_pref.dart';
part 'preference_keys/preference_keys.dart';
part 'preference_keys/reader_pref.dart';
part 'preference_keys/shared_list_prefs.dart';
part 'preference_keys/tts_pref.dart';

class PreferenceService {
  const PreferenceService._();

  static final AppearancePreference appearance = AppearancePreference();
  static final LocalePreference locale = LocalePreference();

  static SharedListPreference bookshelf = SharedListPreference(
    sortOrderKey: PreferenceKeys.bookshelf.sortOrder,
    isAscendingKey: PreferenceKeys.bookshelf.isAscending,
    listTypeKey: PreferenceKeys.bookshelf.listType,
    defaultSortOrder: SortOrderCode.name,
    defaultIsAscending: true,
    defaultListType: SharedListType.grid,
  );

  static SharedListPreference bookmarkList = SharedListPreference(
    sortOrderKey: PreferenceKeys.bookmark.sortOrder,
    isAscendingKey: PreferenceKeys.bookmark.isAscending,
    listTypeKey: PreferenceKeys.bookmark.listType,
    defaultSortOrder: SortOrderCode.name,
    defaultIsAscending: true,
    defaultListType: SharedListType.list,
  );

  static SharedListPreference collectionList = SharedListPreference(
    sortOrderKey: PreferenceKeys.collection.sortOrder,
    isAscendingKey: PreferenceKeys.collection.isAscending,
    listTypeKey: PreferenceKeys.collection.listType,
    defaultSortOrder: SortOrderCode.name,
    defaultIsAscending: true,
    defaultListType: SharedListType.list,
  );
}
