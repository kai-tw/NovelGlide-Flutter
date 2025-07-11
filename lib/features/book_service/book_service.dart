import 'package:shared_preferences/shared_preferences.dart';

import '../../enum/sort_order_code.dart';
import '../../preference_keys/preference_keys.dart';

part 'data/repository/book_preferences.dart';

class BookService {
  BookService._();

  static final BookPreference preference = BookPreference();
}
