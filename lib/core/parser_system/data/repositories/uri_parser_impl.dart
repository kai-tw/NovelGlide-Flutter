import '../../domain/repository/uri_parser.dart';

class UriParserImpl implements UriParser {
  String _concatProtocol(String input, String protocol) {
    if (!_hasProtocol(input)) {
      return '$protocol://$input';
    }
    return input;
  }

  bool _hasProtocol(String input) => input.contains('://');

  @override
  Uri? parseHttps(String input) {
    String normalizedUrl;

    // Protocol check.
    normalizedUrl = _concatProtocol(input, 'https');

    return Uri.tryParse(normalizedUrl);
  }
}
