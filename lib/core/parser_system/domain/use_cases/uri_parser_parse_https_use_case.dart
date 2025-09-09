import '../../../domain/use_cases/use_case.dart';
import '../repository/uri_parser.dart';

class UriParserParseHttpsUseCase extends UseCase<Uri?, String> {
  const UriParserParseHttpsUseCase(this._parser);

  final UriParser _parser;

  @override
  Uri? call(String parameter) {
    return _parser.parseHttps(parameter);
  }
}
