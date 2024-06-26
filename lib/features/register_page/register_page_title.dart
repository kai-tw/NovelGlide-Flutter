import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPageTitle extends StatelessWidget {
  const RegisterPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        appLocalizations.titleWelcomeJoin,
        style: const TextStyle(
          fontSize: 32.0,
        ),
      ),
    );
  }
}