part of 'app_locale_cubit.dart';

class AppLocaleState extends Equatable {
  const AppLocaleState({
    this.locale,
  });

  final Locale? locale;

  @override
  List<Object?> get props => <Object?>[locale];
}
