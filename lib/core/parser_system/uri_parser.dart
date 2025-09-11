class UriParser {
  UriParser._();

  static String _concatProtocol(String input, String protocol) {
    if (!_hasProtocol(input)) {
      return '$protocol://$input';
    }
    return input;
  }

  static bool _hasProtocol(String input) => input.contains('://');

  static Uri? parseHttps(String input) {
    String normalizedUrl;

    // Protocol check.
    normalizedUrl = _concatProtocol(input, 'https');

    return Uri.tryParse(normalizedUrl);
  }
}
