import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPageGreeting extends StatelessWidget {
  const AccountPageGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;
    final String? displayName = user?.displayName;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        displayName == null ? appLocalizations.greetingWord : appLocalizations.greetingPhrase(displayName),
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
    );
  }
}