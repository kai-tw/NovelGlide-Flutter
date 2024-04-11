import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPageDisplayName extends StatelessWidget {
  const AccountPageDisplayName({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;

    return TextFormField(
      decoration: InputDecoration(
        labelText: "${appLocalizations.nickname}${appLocalizations.fieldOptional}",
      ),
      initialValue: user?.displayName,
    );
  }
}