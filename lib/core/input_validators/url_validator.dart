import '../../generated/i18n/app_localizations.dart';

class UrlValidator {
  UrlValidator(this._appLocalizations);

  static final RegExp _looseRegExp = RegExp(
      r'(http(s)?://.)?(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&/=]*)');

  final AppLocalizations _appLocalizations;

  String? validateLoosely(String? value) {
    if (value == null || value.isEmpty) {
      // return _appLocalizations.pleaseEnterUrl;
      return 'Please enter the URL';
    }

    if (!_looseRegExp.hasMatch(value)) {
      // return _appLocalizations.pleaseEnterValidUrl;
      return 'Invalid URL';
    }

    return null;
  }
}
