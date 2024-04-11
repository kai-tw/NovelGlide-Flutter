import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPageButtonRow extends StatelessWidget {
  const AccountPageButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton.icon(
            onPressed: () => _onEditButtonPressed(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
            ),
            icon: const Icon(Icons.edit_rounded, size: 20.0),
            label: Text(appLocalizations.edit),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => _onSignOutButtonPressed(context),
            padding: const EdgeInsets.all(12.0),
            icon: const Icon(Icons.logout_rounded),
          ),
        ),
      ],
    );
  }

  void _onEditButtonPressed(BuildContext context) {

  }

  void _onSignOutButtonPressed(BuildContext context) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil(ModalRoute.withName("/"));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(appLocalizations.signOutSuccessfully),
    ));
  }
}
