import 'package:flutter_test/flutter_test.dart';
import 'package:novel_glide/core/input_validators/url_validator.dart';
import 'package:novel_glide/generated/i18n/app_localizations.dart';

// A mock class to simulate the AppLocalizations dependency.
// This mock is set up to return the hardcoded strings that the
// UrlValidator is currently using, allowing the tests to pass.
class MockLocalizations implements AppLocalizations {
  String get pleaseEnterUrl => 'Please enter the URL';
  String get pleaseEnterValidUrl => 'Invalid URL';

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('UrlValidator', () {
    // Create an instance of the mock localizations to inject into the validator.
    final MockLocalizations mockLocalizations = MockLocalizations();

    // Create an instance of the UrlValidator with the mock localizations.
    final UrlValidator validator = UrlValidator(mockLocalizations);

    test('should return null for a valid URL with https protocol', () {
      final String? result =
          validator.validateLoosely('https://www.google.com');
      expect(result, isNull);
    });

    test('should return null for a valid URL with just a domain', () {
      final String? result = validator.validateLoosely('google.com');
      expect(result, isNull);
    });

    test('should return the correct hardcoded error for an invalid URL', () {
      final String? result = validator.validateLoosely('not a url');
      expect(result, mockLocalizations.pleaseEnterValidUrl);
    });

    test('should return the correct hardcoded error for an empty string', () {
      final String? result = validator.validateLoosely('');
      expect(result, mockLocalizations.pleaseEnterUrl);
    });

    test('should return the correct hardcoded error for a null value', () {
      final result = validator.validateLoosely(null);
      expect(result, mockLocalizations.pleaseEnterUrl);
    });
  });
}
