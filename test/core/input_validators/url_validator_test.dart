import 'package:flutter_test/flutter_test.dart';
import 'package:novel_glide/core/input_validators/url_validator.dart';
import 'package:novel_glide/generated/i18n/app_localizations.dart';

class MockLocalizations implements AppLocalizations {
  @override
  String get validatorRequiredField => 'Required field';

  @override
  String get validatorPleaseEnterValidUrl => 'Invalid URL';

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
      expect(result, mockLocalizations.validatorPleaseEnterValidUrl);
    });

    test('should return the correct hardcoded error for an empty string', () {
      final String? result = validator.validateLoosely('');
      expect(result, mockLocalizations.validatorRequiredField);
    });

    test('should return the correct hardcoded error for a null value', () {
      final String? result = validator.validateLoosely(null);
      expect(result, mockLocalizations.validatorRequiredField);
    });
  });
}
