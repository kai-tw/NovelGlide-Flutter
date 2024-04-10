import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPageTitle extends StatelessWidget {
  const AccountPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String? displayName = FirebaseAuth.instance.currentUser!.displayName;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(appLocalizations.accountPageGreeting(displayName ?? 'user')),
    );
  }
}