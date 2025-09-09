import '../../generated/i18n/app_localizations.dart';
import 'not_empty_validator.dart';

class UrlValidator {
  UrlValidator(this._appLocalizations);

  static final RegExp _looseRegExp = RegExp(
      r'(http(s)?://.)?(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&/=]*)');

  final AppLocalizations _appLocalizations;

  String? validateLoosely(String? value) {
    final NotEmptyValidator notEmptyValidator =
        NotEmptyValidator(_appLocalizations);

    final String? notEmptyResult = notEmptyValidator.validate(value);
    if (notEmptyResult != null) {
      return notEmptyResult;
    }

    if (!_looseRegExp.hasMatch(value!)) {
      return _appLocalizations.validatorPleaseEnterValidUrl;
    }

    return null;
  }
}
