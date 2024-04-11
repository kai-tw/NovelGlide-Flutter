import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPageEmail extends StatelessWidget {
  const AccountPageEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;

    return InputDecorator(
      decoration: InputDecoration(
        labelText: appLocalizations.emailAddress,
      ),
      child: user != null && user.email != null
          ? Text(
              user.email!,
              style: const TextStyle(fontSize: 16.0),
            )
          : null,
    );
  }
}
