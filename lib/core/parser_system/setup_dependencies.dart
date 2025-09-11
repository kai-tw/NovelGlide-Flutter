import '../../main.dart';
import 'data/repositories/datetime_parser_impl.dart';
import 'data/repositories/uri_parser_impl.dart';
import 'domain/repository/datetime_parser.dart';
import 'domain/repository/uri_parser.dart';
import 'domain/use_cases/uri_parser_parse_https_use_case.dart';

void setupParserDependencies() {
  // Register repositories
  sl.registerLazySingleton<DateTimeParser>(
    () => DateTimeParserImpl(),
  );
  sl.registerLazySingleton<UriParser>(
    () => UriParserImpl(),
  );

  // Register use cases
  sl.registerFactory<UriParserParseHttpsUseCase>(
    () => UriParserParseHttpsUseCase(
      sl<UriParser>(),
    ),
  );
}
