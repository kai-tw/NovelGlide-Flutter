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
    if (input.isEmpty) {
      return null;
    }

    String normalizedUrl;

    // Protocol check.
    normalizedUrl = _concatProtocol(input, 'https');

    return Uri.tryParse(normalizedUrl);
  }
}
