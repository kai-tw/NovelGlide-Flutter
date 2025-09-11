import 'package:intl/intl.dart';

import '../log_system/log_system.dart';

class DateTimeParser {
  DateTimeParser._();

  static DateTime? tryParse(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    DateTime? retVal;

    retVal ??= DateTime.tryParse(value);

    final List<String> formatPattern = <String>[
      'EEE, dd MMM yyyy HH:mm:ss Z',
    ];

    for (final String pattern in formatPattern) {
      retVal ??= DateFormat(pattern).tryParse(value);
    }

    if (retVal == null) {
      LogSystem.error('Failed to parse date time: $value');
    }

    return retVal;
  }
}
