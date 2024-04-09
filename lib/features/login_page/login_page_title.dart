import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPageTitle extends StatelessWidget {
  const LoginPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        appLocalizations.titleWelcomeBack,
        style: const TextStyle(
          fontSize: 32.0,
        ),
      ),
    );
  }
}