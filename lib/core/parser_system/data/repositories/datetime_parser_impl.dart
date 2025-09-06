import 'package:intl/intl.dart';

import '../../../log_system/log_system.dart';
import '../../domain/repository/datetime_parser.dart';

class DateTimeParserImpl implements DateTimeParser {
  @override
  DateTime? tryParse(String? value) {
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

    LogSystem.error('Failed to parse date time: $value');
    return retVal;
  }
}
