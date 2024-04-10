import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPageTitle extends StatelessWidget {
  const SignInPageTitle({super.key});

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