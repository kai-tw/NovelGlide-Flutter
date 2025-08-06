import 'package:equatable/equatable.dart';

import 'app_locale.dart';

class LocaleSettings extends Equatable {
  const LocaleSettings({
    this.userLocale,
  });

  final AppLocale? userLocale;

  @override
  List<Object?> get props => <Object?>[
        userLocale,
      ];
}
