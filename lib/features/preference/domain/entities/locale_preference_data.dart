import 'package:equatable/equatable.dart';

import '../../../locale_system/domain/entities/app_locale.dart';

class LocalePreferenceData extends Equatable {
  const LocalePreferenceData({
    this.userLocale,
  });

  final AppLocale? userLocale;

  @override
  List<Object?> get props => <Object?>[
        userLocale,
      ];
}
