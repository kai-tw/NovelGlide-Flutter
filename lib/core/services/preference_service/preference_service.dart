import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/reader/domain/entities/reader_page_num_type.dart';
import 'data/model/reader_preference_data.dart';

part 'data/keys/reader_preference_key.dart';
part 'data/repository/preference_repository.dart';
part 'data/repository/reader_preference.dart';

class PreferenceService {
  const PreferenceService._();

  static final ReaderPreference reader = ReaderPreference();
}
