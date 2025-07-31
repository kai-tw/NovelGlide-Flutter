part of '../../preference_service.dart';

class LocalePreferenceData extends Equatable {
  const LocalePreferenceData({
    this.userLocale,
  });

  final Locale? userLocale;

  @override
  List<Object?> get props => <Object?>[
        userLocale,
      ];
}
