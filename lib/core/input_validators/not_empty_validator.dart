import '../../generated/i18n/app_localizations.dart';

class NotEmptyValidator {
  NotEmptyValidator(this._appLocalizations);

  final AppLocalizations _appLocalizations;

  String? validate(String? value, {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage ?? _appLocalizations.validatorRequiredField;
    }

    return null;
  }
}
